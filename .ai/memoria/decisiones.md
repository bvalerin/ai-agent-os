# Decisiones

## ADR-001: `.ai/` como capa operativa
- Fecha: 2026-03-14
- Estado: aprobada
- Decision: centralizar agentes, workflows, memoria, prompts, contexto y MCP bajo `.ai/`.
- Consecuencia: el proyecto tiene un punto unico de coordinacion humano-agente.

## ADR-002: `docs/` como capa publicada
- Fecha: 2026-03-14
- Estado: aprobada
- Decision: separar documentacion operativa (`.ai/`) de documentacion publicada (`docs/`).
- Consecuencia: se evita mezclar trabajo interno con guias para el equipo.

## ADR-003: Workflows transversales
- Fecha: 2026-03-14
- Estado: aprobada
- Decision: modelar tareas clave como workflows neutrales al stack.
- Consecuencia: el framework puede aplicarse antes de definir tecnologia concreta.

## ADR-004: Taxonomia de pruebas por nivel
- Fecha: 2026-03-14
- Estado: aprobada
- Decision: reservar suites para unit, integracion, api, e2e y performance.
- Consecuencia: la estrategia de calidad nace junto con la estructura del proyecto.
