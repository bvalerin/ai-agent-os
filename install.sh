#!/usr/bin/env bash

set -euo pipefail

export LC_ALL=C
export LANG=C

DEFAULT_REPO="bvalerin/ai-agent-os"
DEFAULT_REF="main"
STATE_DIR_NAME=".agent-os/state"
LOCAL_BIN_DIR=".agent-os/bin"
LOCAL_COMMAND_PATH=".agent-os/bin/agent-os"
INSTALL_STATE_FILE=".agent-os/state/install.env"
STATE_MANIFEST_FILE=".agent-os/state/manifest.tsv"
GITIGNORE_START_MARKER="# >>> agent-os >>>"
GITIGNORE_END_MARKER="# <<< agent-os <<<"

MODE="install"
FORCE=0
REPO="${AGENT_OS_REPO:-$DEFAULT_REPO}"
REF="${AGENT_OS_REF:-$DEFAULT_REF}"
TARGET_DIR="${PWD}"
SOURCE_DIR="${AGENT_OS_SOURCE_DIR:-}"
WORK_DIR=""

cleanup() {
  if [[ -n "$WORK_DIR" && -d "$WORK_DIR" ]]; then
    rm -rf "$WORK_DIR"
  fi
}

trap cleanup EXIT

log() {
  printf '%s\n' "$*"
}

warn() {
  printf 'WARN: %s\n' "$*" >&2
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

usage() {
  cat <<'EOF'
Usage:
  bash install.sh [options]

Options:
  --update              Update an existing Agent OS installation.
  --force               Overwrite managed files even if they changed locally.
  --repo OWNER/REPO     GitHub repository slug. Default: bvalerin/ai-agent-os
  --ref REF             Git ref to install. Default: main
  --target-dir DIR      Project directory where files will be installed.
  --source-dir DIR      Use a local checkout instead of downloading from GitHub.
  --help                Show this help message.

Install from GitHub:
  curl -fsSL https://raw.githubusercontent.com/bvalerin/ai-agent-os/main/install.sh | bash

Update from GitHub:
  curl -fsSL https://raw.githubusercontent.com/bvalerin/ai-agent-os/main/install.sh | bash -s -- --update
EOF
}

require_command() {
  local command_name="$1"

  if ! command -v "$command_name" >/dev/null 2>&1; then
    die "Required command not found: $command_name"
  fi
}

resolve_dir() {
  local path="$1"

  mkdir -p "$path"
  (
    cd "$path" >/dev/null 2>&1
    pwd -P
  )
}

fetch_url() {
  local url="$1"
  local destination="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$destination"
    return 0
  fi

  if command -v wget >/dev/null 2>&1; then
    wget -qO "$destination" "$url"
    return 0
  fi

  die "curl or wget is required to download Agent OS."
}

hash_file() {
  local file_path="$1"

  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$file_path" | awk '{print $1}'
    return 0
  fi

  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$file_path" | awk '{print $1}'
    return 0
  fi

  if command -v openssl >/dev/null 2>&1; then
    openssl dgst -sha256 "$file_path" | awk '{print $NF}'
    return 0
  fi

  die "shasum, sha256sum, or openssl is required to verify file changes."
}

copy_file() {
  local source_path="$1"
  local destination_path="$2"

  mkdir -p "$(dirname "$destination_path")"
  cp "$source_path" "$destination_path"

  if [[ -x "$source_path" ]]; then
    chmod +x "$destination_path"
  fi
}

write_candidate_file() {
  local source_path="$1"
  local destination_path="$2"
  local candidate_path="${destination_path}.agent-os-new"

  copy_file "$source_path" "$candidate_path"
}

lookup_previous_checksum() {
  local manifest_path="$1"
  local relative_path="$2"

  if [[ ! -f "$manifest_path" ]]; then
    return 0
  fi

  awk -F '\t' -v relative_path="$relative_path" '$2 == relative_path { print $1; exit }' "$manifest_path"
}

download_source() {
  local repo="$1"
  local ref="$2"
  local runtime_dir="$3"
  local archive_path="$runtime_dir/source.tar.gz"
  local archive_url="https://codeload.github.com/${repo}/tar.gz/${ref}"
  local extracted_dir=""

  printf 'Downloading Agent OS from %s@%s...\n' "$repo" "$ref" >&2
  fetch_url "$archive_url" "$archive_path"
  tar -xzf "$archive_path" -C "$runtime_dir"

  extracted_dir="$(find "$runtime_dir" -mindepth 1 -maxdepth 1 -type d | head -n 1)"

  if [[ -z "$extracted_dir" || ! -d "$extracted_dir" ]]; then
    die "Could not extract Agent OS archive."
  fi

  printf '%s\n' "$extracted_dir"
}

build_file_list() {
  local source_root="$1"
  local output_path="$2"
  local manifest_path="$source_root/install-manifest.txt"

  [[ -f "$manifest_path" ]] || die "install-manifest.txt not found in source."

  (
    cd "$source_root"

    while IFS= read -r entry || [[ -n "$entry" ]]; do
      case "$entry" in
        ''|'#'*)
          continue
          ;;
      esac

      if [[ -d "$entry" ]]; then
        find "$entry" -type f
        continue
      fi

      if [[ -f "$entry" ]]; then
        printf '%s\n' "$entry"
        continue
      fi

      die "Manifest entry not found: $entry"
    done < "$manifest_path" | LC_ALL=C sort -u > "$output_path"
  )
}

build_gitignore_entries() {
  local source_root="$1"
  local output_path="$2"
  local manifest_path="$source_root/install-manifest.txt"

  [[ -f "$manifest_path" ]] || die "install-manifest.txt not found in source."

  {
    printf '/.agent-os/\n'

    while IFS= read -r entry || [[ -n "$entry" ]]; do
      case "$entry" in
        ''|'#'*)
          continue
          ;;
      esac

      if [[ -d "$source_root/$entry" ]]; then
        printf '/%s/\n' "${entry#./}"
        continue
      fi

      printf '/%s\n' "${entry#./}"
    done < "$manifest_path"
  } | awk '!seen[$0]++' > "$output_path"
}

write_gitignore_block() {
  local target_root="$1"
  local entries_path="$2"
  local gitignore_path="$target_root/.gitignore"
  local temp_path="$WORK_DIR/gitignore.tmp"

  if [[ -f "$gitignore_path" ]]; then
    awk -v start="$GITIGNORE_START_MARKER" -v end="$GITIGNORE_END_MARKER" '
      $0 == start { skip = 1; next }
      $0 == end { skip = 0; next }
      !skip { print }
    ' "$gitignore_path" > "$temp_path"
  else
    : > "$temp_path"
  fi

  if [[ -s "$temp_path" ]]; then
    printf '\n' >> "$temp_path"
  fi

  {
    printf '%s\n' "$GITIGNORE_START_MARKER"
    cat "$entries_path"
    printf '%s\n' "$GITIGNORE_END_MARKER"
  } >> "$temp_path"

  mv "$temp_path" "$gitignore_path"
}

write_install_state() {
  local target_root="$1"
  local repo="$2"
  local ref="$3"
  local install_mode="$4"
  local state_file="$target_root/$INSTALL_STATE_FILE"

  mkdir -p "$(dirname "$state_file")"

  cat > "$state_file" <<EOF
AGENT_OS_REPO="$repo"
AGENT_OS_REF="$ref"
AGENT_OS_LAST_COMMAND="$install_mode"
AGENT_OS_LAST_UPDATED_AT="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
EOF
}

write_local_command() {
  local target_root="$1"
  local local_command="$target_root/$LOCAL_COMMAND_PATH"

  mkdir -p "$(dirname "$local_command")"

  cat > "$local_command" <<'EOF'
#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
STATE_FILE="$ROOT_DIR/.agent-os/state/install.env"

if [[ -f "$STATE_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$STATE_FILE"
fi

REPO="${AGENT_OS_REPO:-bvalerin/ai-agent-os}"
REF="${AGENT_OS_REF:-main}"
INSTALL_URL="https://raw.githubusercontent.com/${REPO}/${REF}/install.sh"

run_remote_install() {
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$INSTALL_URL" | bash -s -- "$@"
    return 0
  fi

  if command -v wget >/dev/null 2>&1; then
    wget -qO- "$INSTALL_URL" | bash -s -- "$@"
    return 0
  fi

  echo "ERROR: curl or wget is required." >&2
  exit 1
}

usage() {
  cat <<EOT
Usage:
  ./.agent-os/bin/agent-os update
  ./.agent-os/bin/agent-os version
  ./.agent-os/bin/agent-os help

Current source:
  repo: ${REPO}
  ref:  ${REF}
EOT
}

command_name="${1:-help}"

case "$command_name" in
  update)
    shift
    run_remote_install --update --target-dir "$ROOT_DIR" --repo "$REPO" --ref "$REF" "$@"
    ;;
  reinstall)
    shift
    run_remote_install --force --target-dir "$ROOT_DIR" --repo "$REPO" --ref "$REF" "$@"
    ;;
  version)
    printf 'repo=%s\n' "$REPO"
    printf 'ref=%s\n' "$REF"
    if [[ -f "$STATE_FILE" ]]; then
      awk -F '=' '/^AGENT_OS_LAST_UPDATED_AT=/{gsub(/"/, "", $2); print "updated_at=" $2}' "$STATE_FILE"
    fi
    ;;
  help|-h|--help)
    usage
    ;;
  *)
    echo "Unknown command: $command_name" >&2
    usage >&2
    exit 1
    ;;
esac
EOF

  chmod +x "$local_command"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --update)
      MODE="update"
      ;;
    --force)
      FORCE=1
      ;;
    --repo)
      shift
      [[ $# -gt 0 ]] || die "--repo requires a value."
      REPO="$1"
      ;;
    --ref)
      shift
      [[ $# -gt 0 ]] || die "--ref requires a value."
      REF="$1"
      ;;
    --target-dir)
      shift
      [[ $# -gt 0 ]] || die "--target-dir requires a value."
      TARGET_DIR="$1"
      ;;
    --source-dir)
      shift
      [[ $# -gt 0 ]] || die "--source-dir requires a value."
      SOURCE_DIR="$1"
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      die "Unknown argument: $1"
      ;;
  esac

  shift
done

require_command tar
require_command awk
require_command mktemp

TARGET_DIR="$(resolve_dir "$TARGET_DIR")"
WORK_DIR="$(mktemp -d)"

if [[ -n "$SOURCE_DIR" ]]; then
  SOURCE_DIR="$(resolve_dir "$SOURCE_DIR")"
else
  SOURCE_DIR="$(download_source "$REPO" "$REF" "$WORK_DIR")"
fi

[[ -d "$SOURCE_DIR" ]] || die "Source directory not found: $SOURCE_DIR"

FILE_LIST_PATH="$WORK_DIR/file-list.txt"
NEXT_MANIFEST_PATH="$WORK_DIR/manifest.next.tsv"
GITIGNORE_ENTRIES_PATH="$WORK_DIR/gitignore.entries"
PREVIOUS_MANIFEST_PATH="$TARGET_DIR/$STATE_MANIFEST_FILE"

build_file_list "$SOURCE_DIR" "$FILE_LIST_PATH"
build_gitignore_entries "$SOURCE_DIR" "$GITIGNORE_ENTRIES_PATH"
: > "$NEXT_MANIFEST_PATH"

installed_count=0
updated_count=0
preserved_count=0
conflict_count=0
skipped_count=0
managed_count=0

if [[ "$MODE" == "install" ]]; then
  log "Installing Agent OS into $TARGET_DIR"
else
  log "Updating Agent OS in $TARGET_DIR"
fi

while IFS= read -r relative_path || [[ -n "$relative_path" ]]; do
  [[ -n "$relative_path" ]] || continue

  managed_count=$((managed_count + 1))

  source_path="$SOURCE_DIR/$relative_path"
  destination_path="$TARGET_DIR/$relative_path"
  source_checksum="$(hash_file "$source_path")"
  previous_checksum="$(lookup_previous_checksum "$PREVIOUS_MANIFEST_PATH" "$relative_path")"
  next_baseline=""

  if [[ ! -f "$destination_path" ]]; then
    copy_file "$source_path" "$destination_path"
    next_baseline="$source_checksum"
    installed_count=$((installed_count + 1))
    log "Installed: $relative_path"
  else
    current_checksum="$(hash_file "$destination_path")"

    if [[ "$FORCE" -eq 1 ]]; then
      copy_file "$source_path" "$destination_path"
      next_baseline="$source_checksum"
      updated_count=$((updated_count + 1))
      log "Overwritten: $relative_path"
    elif [[ -z "$previous_checksum" ]]; then
      if [[ "$current_checksum" == "$source_checksum" ]]; then
        next_baseline="$source_checksum"
        skipped_count=$((skipped_count + 1))
      else
        write_candidate_file "$source_path" "$destination_path"
        conflict_count=$((conflict_count + 1))
        warn "Skipped unmanaged file: $relative_path"
        warn "Wrote candidate update: ${relative_path}.agent-os-new"
      fi
    elif [[ "$current_checksum" == "$source_checksum" ]]; then
      next_baseline="$source_checksum"
      skipped_count=$((skipped_count + 1))
    elif [[ "$current_checksum" == "$previous_checksum" ]]; then
      copy_file "$source_path" "$destination_path"
      next_baseline="$source_checksum"
      updated_count=$((updated_count + 1))
      log "Updated: $relative_path"
    elif [[ "$source_checksum" == "$previous_checksum" ]]; then
      next_baseline="$previous_checksum"
      preserved_count=$((preserved_count + 1))
      warn "Preserved local changes: $relative_path"
    else
      write_candidate_file "$source_path" "$destination_path"
      next_baseline="$previous_checksum"
      conflict_count=$((conflict_count + 1))
      warn "Conflict detected: $relative_path"
      warn "Wrote candidate update: ${relative_path}.agent-os-new"
    fi
  fi

  if [[ -n "$next_baseline" ]]; then
    printf '%s\t%s\n' "$next_baseline" "$relative_path" >> "$NEXT_MANIFEST_PATH"
  fi
done < "$FILE_LIST_PATH"

mkdir -p "$TARGET_DIR/$STATE_DIR_NAME" "$TARGET_DIR/$LOCAL_BIN_DIR"
cp "$NEXT_MANIFEST_PATH" "$TARGET_DIR/$STATE_MANIFEST_FILE"
write_install_state "$TARGET_DIR" "$REPO" "$REF" "$MODE"
write_local_command "$TARGET_DIR"
write_gitignore_block "$TARGET_DIR" "$GITIGNORE_ENTRIES_PATH"

log ""
log "Agent OS ready."
log "Managed files: $managed_count"
log "Installed: $installed_count"
log "Updated: $updated_count"
log "Preserved local changes: $preserved_count"
log "Conflicts: $conflict_count"
log "Skipped: $skipped_count"
log ""
log "Local commands:"
log "  ./.agent-os/bin/agent-os update"
log "  ./.agent-os/bin/agent-os version"
log "Git ignore updated: .gitignore"
