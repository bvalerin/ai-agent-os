# Decisiones

## ADR-001: `.ai/` como capa operativa
- Fecha: 2026-03-14
- Estado: aprobada
- Decision: centralizar agentes, workflows, memoria, prompts, contexto y MCP bajo `.ai/`.
- Consecuencia: el proyecto tiene un punto unico de coordinacion humano-agente.

## ADR-002: `.ai/` como fuente unica de documentacion del proyecto
- Fecha: 2026-03-14
- Estado: aprobada
- Decision: concentrar la memoria, las decisiones y la documentacion operativa directamente en `.ai/`.
- Consecuencia: el framework reduce superficie de mantenimiento y evita duplicar contenido entre carpetas.

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

## ADR-005: `.ai/` como objetivo canonico de instalacion
- Fecha: 2026-03-14
- Estado: aprobada
- Decision: instalar la capa operativa siempre en `.ai/` y reservar `.agent-os/` para metadatos y utilidades del instalador.
- Consecuencia: el sistema evita rutas duplicadas como `.ia/` o `agent-os/` para el mismo contenido.

## ADR-006: Instalacion y update por manifiesto
- Fecha: 2026-03-14
- Estado: aprobada
- Decision: distribuir Agent OS mediante `install.sh`, un manifiesto de archivos gestionados y actualizaciones que preservan cambios locales por defecto.
- Consecuencia: el framework puede instalarse en cualquier proyecto con `curl | bash` sin depender de Composer ni sobrescribir trabajo del usuario.
