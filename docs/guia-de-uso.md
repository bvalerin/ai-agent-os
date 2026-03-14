# Guia de uso de agent-os

Esta guia explica como utilizar `agent-os` para obtener resultados consistentes, mantener contexto y evitar trabajo desordenado.

## 1. Modelo mental

`agent-os` no es solo una carpeta de prompts. Es una forma de operar el proyecto con cuatro piezas coordinadas:

- Agentes: definen roles y responsabilidades.
- Workflows: definen como ejecutar tareas repetibles.
- Memoria: preserva contexto, decisiones y pendientes.
- Docs: publica una version legible para el equipo.

La regla base es simple: no empezar a construir sin contexto y no cerrar trabajo sin dejar evidencia.

## 2. Flujo correcto de trabajo

Para usar el framework de forma optima, sigue esta secuencia:

1. Entender el objetivo.
   Determina si la tarea es crear, refactorizar, revisar, investigar un bug, hacer onboarding o preparar release.
2. Leer memoria antes de actuar.
   Revisa como minimo `.ai/memoria/vision.md`, `.ai/memoria/arquitectura.md`, `.ai/memoria/dominio.md` y `.ai/memoria/convenciones.md`.
3. Elegir el workflow correcto.
   Usa un archivo de `.ai/workflows/` como procedimiento principal.
4. Involucrar los agentes necesarios.
   No todas las tareas requieren todos los agentes. El orquestador debe elegir los especialistas correctos.
5. Ejecutar el cambio o analisis.
   Implementa, revisa o investiga con base en contratos, no en supuestos.
6. Validar.
   Toda tarea tecnica debe dejar pruebas, hallazgos, o riesgo residual explicitado.
7. Actualizar memoria y docs.
   Si cambia el dominio, la arquitectura, los modulos o las decisiones, debes reflejarlo.

## 3. Como elegir agentes

Usa esta regla de seleccion:

- `orchestrator`: coordina la tarea y decide secuencia.
- `arquitecto`: cambios estructurales, nuevos modulos, contratos y limites.
- `backend`: servicios, APIs, jobs e integraciones del lado servidor.
- `frontend`: UI, estados de pantalla, accesibilidad e integraciones cliente.
- `qa`: estrategia de pruebas, validacion y bugs.
- `security`: auth, secretos, permisos, datos sensibles y superficies de ataque.
- `devops`: despliegue, entornos, CI/CD y observabilidad.
- `data`: modelos, calidad, contratos semanticos y cambios de esquema.
- `docs`: documentacion publicada y guias operativas.

## 4. Como elegir workflows

Selecciona uno principal segun el objetivo:

- `onboard-proyecto.md`: cuando el repo es nuevo o poco conocido.
- `crear-modulo.md`: cuando necesitas agregar una capacidad nueva.
- `refactorizar-modulo.md`: cuando quieres mejorar estructura sin cambiar comportamiento esperado.
- `revisar-codigo.md`: cuando necesitas una revision tecnica con foco en riesgo.
- `generar-pruebas.md`: cuando falta cobertura o quieres automatizar validaciones.
- `ejecutar-qa.md`: cuando ya tienes un cambio y necesitas emitir estado de calidad.
- `investigar-bug.md`: cuando el objetivo es aislar y reproducir un defecto.
- `preparar-release.md`: cuando el cambio debe pasar a una version desplegable.

## 5. Uso optimo de la memoria

La memoria no es opcional. Sin ella, el framework pierde valor.

Actualiza estos archivos cuando aplique:

- `.ai/memoria/vision.md`: si cambia el proposito o alcance del proyecto.
- `.ai/memoria/dominio.md`: si cambia el lenguaje comun, entidades o reglas.
- `.ai/memoria/arquitectura.md`: si cambian capas, modulos o integraciones principales.
- `.ai/memoria/decisiones.md`: si tomas una decision importante o dificil de revertir.
- `.ai/memoria/modulos.md`: si agregas, deprecas o cambias responsabilidades de modulos.
- `.ai/memoria/pendientes.md`: si identificas gaps o trabajo futuro relevante.

## 6. Uso correcto de prompts

Los prompts en `.ai/prompts/` sirven para acelerar trabajo, no para reemplazar criterio.

Buenas practicas:
- Usa prompts con contexto concreto del repo.
- Rellena objetivo, restricciones y contratos esperados.
- Si un prompt produce una decision estructural, registrala en memoria.
- Si un prompt produce codigo, ese codigo igual debe pasar por workflow de pruebas y revision.

## 7. Uso correcto de MCP

MCP debe mejorar trazabilidad y velocidad, no introducir opacidad.

Recomendaciones:
- Empieza por `filesystem` y `git`.
- Activa `browser` solo si el proyecto realmente necesita validacion navegada.
- Agrega `docs` o `database` cuando la tarea dependa de fuentes externas o datos reales.
- Registra en decisiones cualquier integracion MCP importante.

Referencia inicial:
- `.ai/mcp/mcp.example.json`
- `.ai/mcp/servidores-recomendados.md`

## 8. Criterio de cierre de una tarea

Una tarea no esta realmente terminada si falta alguno de estos puntos:

- Cambio, analisis o decision principal realizado.
- Evidencia minima de validacion.
- Riesgos abiertos explicitados.
- Memoria actualizada si el contexto cambio.
- Docs actualizadas si el equipo necesita consumir el resultado.

## 9. Errores comunes

Evita estos anti-patrones:

- Crear modulos sin revisar memoria ni arquitectura.
- Usar muchos agentes sin una secuencia clara.
- Saltarse QA porque el cambio "parece pequeno".
- Documentar solo al final y perder decisiones intermedias.
- Usar prompts genericos sin contexto del proyecto.
- Cerrar tareas sin registrar pendientes o riesgo residual.

## 10. Recorrido recomendado para nuevos proyectos

Si el repositorio esta arrancando desde cero, este es el orden recomendado:

1. Ejecuta `scripts/bootstrap-agent-os.sh`.
2. Completa `.ai/contexto/stack.md`, `.ai/contexto/entornos.md` y `.ai/contexto/integraciones.md`.
3. Recorre `.ai/memoria/vision.md`, `.ai/memoria/dominio.md` y `.ai/memoria/arquitectura.md`.
4. Registra decisiones iniciales en `.ai/memoria/decisiones.md`.
5. Usa `onboard-proyecto.md` o `crear-modulo.md` como primer workflow real.
6. Sincroniza memoria a `docs/` con `scripts/sync-memory.sh`.

## 11. Recorrido recomendado para cambios normales

Para una tarea ya delimitada:

1. El orquestador clasifica el objetivo.
2. Se elige workflow principal.
3. Se leen memoria y contexto pertinentes.
4. Trabajan solo los agentes necesarios.
5. Se ejecuta QA o revision.
6. Se actualizan memoria y docs.

## 12. Siguiente lectura

Despues de esta guia, pasa a:

- [Playbook operativo](./runbooks/playbook-operativo.md)
- [Arquitectura](./arquitectura/README.md)
- [Decisiones](./decisiones/README.md)
