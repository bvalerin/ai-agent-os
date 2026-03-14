# agent-os

`agent-os` es una base de proyecto para operar software con agentes de IA de forma estructurada.

## Que incluye
- Roles de agentes en `.ai/agentes/`
- Workflows reutilizables en `.ai/workflows/`
- Memoria viva del proyecto en `.ai/memoria/`
- Prompts y plantillas para tareas comunes
- Referencia MCP para herramientas
- Documentacion publicada en `docs/`
- Scripts de bootstrap, sync de memoria y QA

## Uso rapido
1. Revisa `.ai/README.md`.
2. Revisa `docs/guia-de-uso.md`.
3. Define stack y decisiones iniciales en `.ai/contexto/` y `.ai/memoria/`.
4. Ajusta `.ai/mcp/mcp.example.json` para tu entorno.
5. Ejecuta `scripts/bootstrap-agent-os.sh`.
6. Sincroniza memoria a `docs/` con `scripts/sync-memory.sh`.

## Documentacion recomendada
- `docs/README.md`: mapa de documentacion.
- `docs/guia-de-uso.md`: como usar agent-os correctamente.
- `docs/runbooks/playbook-operativo.md`: escenarios y flujos practicos.

## Estado actual
El repositorio esta en fase inicial y sirve como plantilla operativa para proyectos con agentes.
