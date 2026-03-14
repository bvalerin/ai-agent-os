# Agent OS

`agent-os` define la capa operativa del proyecto para trabajar con agentes de IA de forma consistente, auditable y reutilizable.

## Objetivo
- Coordinar agentes especializados.
- Estandarizar workflows tecnicos.
- Mantener memoria viva del proyecto.
- Separar contexto, plantillas y configuracion de MCP.

## Estructura
- `agentes/`: roles, reglas, entradas y salidas esperadas.
- `workflows/`: procedimientos repetibles para tareas clave.
- `pruebas/`: espacios reservados para suites por nivel.
- `memoria/`: conocimiento persistente del proyecto.
- `prompts/`: prompts reutilizables por objetivo.
- `plantillas/`: formatos base para modulos, ADRs y reportes.
- `contexto/`: stack, entornos, integraciones y glosario.
- `mcp/`: referencia para herramientas y servidores recomendados.

## Comandos locales
- `./.agent-os/bin/agent-os update`: actualiza los archivos gestionados sin pisar cambios locales por defecto.
- `scripts/agent-os-bootstrap.sh`: repara o verifica la estructura base del proyecto.
- `scripts/agent-os-qa.sh`: ejecuta QA segun el stack detectado.

## Reglas operativas
1. Todo cambio tecnico que afecte estructura o dominio debe reflejarse en `memoria/`.
2. Todo workflow debe dejar una salida concreta: codigo, decision, reporte o evidencia.
3. Los prompts son reutilizables; no reemplazan memoria ni decisiones.
4. La carpeta `.ai/` concentra el contexto operativo y documental del proyecto.

## Estado inicial
- El repositorio aun no contiene codigo de aplicacion.
- Esta estructura establece el estandar base antes de elegir runtime y stack final.
