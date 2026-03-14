#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

declare -a REQUIRED_DIRS=(
  ".ai/agentes"
  ".ai/workflows"
  ".ai/pruebas/e2e"
  ".ai/pruebas/api"
  ".ai/pruebas/unit"
  ".ai/pruebas/integracion"
  ".ai/pruebas/performance"
  ".ai/memoria"
  ".ai/prompts"
  ".ai/plantillas"
  ".ai/contexto"
  ".ai/mcp"
  "scripts"
)

echo "Verifying Agent OS structure in: $ROOT_DIR"

for dir in "${REQUIRED_DIRS[@]}"; do
  mkdir -p "$ROOT_DIR/$dir"
done

echo "Structure verified."
echo "Next steps:"
echo "1. Review .ai/README.md"
echo "2. Complete .ai/contexto/stack.md and .ai/contexto/integraciones.md"
echo "3. Choose a workflow from .ai/workflows/ and start with real project context"
