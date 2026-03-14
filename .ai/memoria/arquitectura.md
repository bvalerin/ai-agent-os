# Arquitectura

## Estado actual
- Fecha base: 2026-03-14.
- El repositorio esta en fase de bootstrap.
- `agent-os` es la primera capa del sistema.

## Capas objetivo
1. Interfaces
   CLI, API o UI para iniciar tareas y consultar estado.
2. Orquestacion
   Seleccion de agentes, workflows y handoffs.
3. Especialistas
   Agentes de backend, frontend, QA, security, data, docs y devops.
4. Herramientas
   Integraciones via MCP con filesystem, git, browser, docs y datos.
5. Memoria
   Vision, arquitectura, decisiones, convenciones, modulos y pendientes.
6. Distribucion
   `install.sh` como bootstrap universal, `.ai/` como contenido canónico instalado y `.agent-os/` como estado local del instalador.

## Principios
- Contratos explicitos antes de automatizacion compleja.
- Separacion entre decision, ejecucion y documentacion.
- Cambios pequenos, reversibles y medibles.
- Seguridad y observabilidad desde el diseno.

## Riesgos abiertos
- Stack principal aun no definido.
- Runtime de agentes aun no definido.
- Estrategia de persistencia de memoria aun no definida.
