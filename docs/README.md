# Documentacion de agent-os

Esta carpeta contiene la documentacion publicada para usar `agent-os` de forma correcta y consistente.

## Empieza aqui
- [Guia de uso](./guia-de-uso.md): explica como trabajar con el framework de punta a punta.
- [Playbook operativo](./runbooks/playbook-operativo.md): escenarios concretos para usar agentes, workflows y memoria.

## Mapa de la documentacion
- [Arquitectura](./arquitectura/README.md): vision tecnica, arquitectura y convenciones publicadas.
- [Dominio](./dominio/README.md): lenguaje comun, objetivos y limites del sistema.
- [Decisiones](./decisiones/README.md): ADRs y cambios estructurales relevantes.
- [Runbooks](./runbooks/README.md): guias operativas para tareas repetibles.

## Cuando leer cada cosa
- Si vas a empezar en el proyecto: revisa primero la guia de uso.
- Si vas a ejecutar una tarea concreta: usa el playbook operativo.
- Si vas a cambiar estructura o contratos: revisa arquitectura y decisiones.
- Si vas a publicar o operar el sistema: revisa runbooks y memoria vigente.

## Relacion con `.ai/`
- `.ai/` es la capa operativa donde viven agentes, workflows, memoria y prompts.
- `docs/` es la capa publicada para el equipo.
- La documentacion de `docs/` debe reflejar lo que ya existe o se decidio en `.ai/`.
