# agent-os

`agent-os` es una base de proyecto para operar software con agentes de IA de forma estructurada.

## Instalacion

Instala la estructura base en cualquier proyecto con un solo comando:

```bash
curl -fsSL https://raw.githubusercontent.com/bvalerin/ai-agent-os/main/install.sh | bash
```

Actualiza una instalacion existente con cualquiera de estas opciones:

```bash
curl -fsSL https://raw.githubusercontent.com/bvalerin/ai-agent-os/main/install.sh | bash -s -- --update
```

```bash
./.agent-os/bin/agent-os update
```

## Que incluye
- Roles de agentes en `.ai/agentes/`
- Workflows reutilizables en `.ai/workflows/`
- Memoria viva del proyecto en `.ai/memoria/`
- Prompts y plantillas para tareas comunes
- Referencia MCP para herramientas
- Scripts namespaced en `scripts/agent-os-*.sh`
- Metadata local del instalador en `.agent-os/`
- Bloque gestionado en `.gitignore` para lo que instala Agent OS

## Uso rapido
1. Revisa `.ai/README.md`.
2. Revisa `.ai/workflows/onboard-proyecto.md`.
3. Define stack y decisiones iniciales en `.ai/contexto/` y `.ai/memoria/`.
4. Ajusta `.ai/mcp/mcp.example.json` para tu entorno.
5. Ejecuta `scripts/agent-os-bootstrap.sh` si quieres reparar o verificar la estructura.
6. Usa `./.agent-os/bin/agent-os update` para mantener la instalacion al dia.

## Documentacion recomendada
- `.ai/README.md`: modelo operativo base.
- `.ai/workflows/onboard-proyecto.md`: primer workflow para repos nuevos o poco conocidos.
- `.ai/prompts/analizar-proyecto.md`: prompt base para analisis inicial con contexto.

## Estado actual
El repositorio esta en fase inicial y sirve como plantilla operativa para proyectos con agentes.
