#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

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
  "docs/arquitectura"
  "docs/dominio"
  "docs/decisiones"
  "docs/runbooks"
  "scripts"
)

echo "Bootstrapping Agent OS in: $ROOT_DIR"

for dir in "${REQUIRED_DIRS[@]}"; do
  mkdir -p "$ROOT_DIR/$dir"
done

echo "Directory structure verified."
echo "Next steps:"
echo "1. Review .ai/memoria/pendientes.md"
echo "2. Define stack in .ai/contexto/stack.md"
echo "3. Configure MCP from .ai/mcp/mcp.example.json"
