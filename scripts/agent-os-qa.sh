#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
TARGET="${1:-all}"

run_node_tests() {
  local level="$1"

  if [[ -f "$ROOT_DIR/package.json" ]]; then
    if command -v pnpm >/dev/null 2>&1; then
      pnpm run "test:${level}" || pnpm test
      return 0
    fi

    if command -v npm >/dev/null 2>&1; then
      npm run "test:${level}" || npm test
      return 0
    fi
  fi

  return 1
}

run_python_tests() {
  local level="$1"

  if [[ -f "$ROOT_DIR/pyproject.toml" || -f "$ROOT_DIR/pytest.ini" ]]; then
    if command -v pytest >/dev/null 2>&1; then
      pytest -m "$level" || pytest
      return 0
    fi
  fi

  return 1
}

run_go_tests() {
  if [[ -f "$ROOT_DIR/go.mod" ]] && command -v go >/dev/null 2>&1; then
    go test ./...
    return 0
  fi

  return 1
}

run_level() {
  local level="$1"

  echo "Running QA target: $level"

  run_node_tests "$level" && return 0
  run_python_tests "$level" && return 0
  run_go_tests && return 0

  echo "No compatible test runner detected for target '$level'."
  return 1
}

case "$TARGET" in
  unit|integracion|api|e2e|performance)
    run_level "$TARGET"
    ;;
  all)
    status=0
    for level in unit integracion api e2e performance; do
      run_level "$level" || status=$?
    done
    exit "$status"
    ;;
  *)
    echo "Usage: $0 [unit|integracion|api|e2e|performance|all]"
    exit 1
    ;;
esac
