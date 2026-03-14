#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

copy_file() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"
  cp "$source" "$target"
  echo "Synced: ${target#$ROOT_DIR/}"
}

copy_file "$ROOT_DIR/.ai/memoria/vision.md" "$ROOT_DIR/docs/arquitectura/vision.md"
copy_file "$ROOT_DIR/.ai/memoria/arquitectura.md" "$ROOT_DIR/docs/arquitectura/arquitectura.md"
copy_file "$ROOT_DIR/.ai/memoria/convenciones.md" "$ROOT_DIR/docs/arquitectura/convenciones.md"
copy_file "$ROOT_DIR/.ai/memoria/dominio.md" "$ROOT_DIR/docs/dominio/dominio.md"
copy_file "$ROOT_DIR/.ai/memoria/decisiones.md" "$ROOT_DIR/docs/decisiones/decisiones.md"

echo "Memory sync complete."
