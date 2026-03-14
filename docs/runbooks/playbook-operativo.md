# Playbook operativo de agent-os

Este playbook resume como usar `agent-os` en escenarios reales. La idea es reducir improvisacion y hacer repetible el trabajo.

## Escenario 1: Onboarding de un proyecto

Usalo cuando:
- El repositorio es nuevo.
- No conoces el stack ni los modulos.
- Falta contexto tecnico minimo.

Workflow principal:
- `.ai/workflows/onboard-proyecto.md`

Agentes recomendados:
- `orchestrator`
- `arquitecto`
- `docs`

Archivos a revisar primero:
- `.ai/contexto/stack.md`
- `.ai/contexto/entornos.md`
- `.ai/contexto/integraciones.md`
- `.ai/memoria/vision.md`
- `.ai/memoria/arquitectura.md`

Resultado esperado:
- Contexto base del repo completo.
- Memoria inicial actualizada.
- Resumen publicado en `docs/`.

Prompt sugerido:
```text
Usa el workflow onboard-proyecto.
Objetivo: entender el repositorio y dejar memoria base util.
Entrega: stack detectado, arquitectura actual, integraciones, riesgos y pendientes.
```

## Escenario 2: Crear un modulo nuevo

Usalo cuando:
- Hay una feature nueva.
- Falta una capacidad del sistema.
- Se quiere agregar un modulo reusable.

Workflow principal:
- `.ai/workflows/crear-modulo.md`

Agentes recomendados:
- `orchestrator`
- `arquitecto`
- `backend` o `frontend`
- `qa`
- `docs`

Archivos a revisar primero:
- `.ai/memoria/vision.md`
- `.ai/memoria/dominio.md`
- `.ai/memoria/arquitectura.md`
- `.ai/memoria/convenciones.md`
- `.ai/plantillas/modulo-base.md`

Resultado esperado:
- Modulo creado con contrato claro.
- Cobertura minima definida.
- Registro del modulo en memoria.

Prompt sugerido:
```text
Usa el workflow crear-modulo.
Modulo: <nombre>
Objetivo: <objetivo funcional>
Contrato esperado: <entradas/salidas/errores>
Restricciones: <seguridad/performance/observabilidad>
```

## Escenario 3: Refactorizar un modulo

Usalo cuando:
- Hay duplicacion o deuda tecnica.
- La complejidad esta creciendo.
- El comportamiento debe mantenerse estable.

Workflow principal:
- `.ai/workflows/refactorizar-modulo.md`

Agentes recomendados:
- `orchestrator`
- `arquitecto` si cambia estructura
- `backend` o `frontend`
- `qa`

Archivos a revisar primero:
- Modulo afectado
- `.ai/memoria/arquitectura.md`
- `.ai/memoria/convenciones.md`

Resultado esperado:
- Menor complejidad.
- Sin regresiones evidentes.
- Memoria ajustada si cambia estructura.

Prompt sugerido:
```text
Usa el workflow refactorizar-modulo.
Objetivo: reducir complejidad sin cambiar comportamiento observable.
Area afectada: <modulo o rutas>
Riesgo principal: <riesgo>
```

## Escenario 4: Revisar codigo

Usalo cuando:
- Existe una rama o cambio listo para revisar.
- Necesitas findings y riesgos, no solo un resumen.

Workflow principal:
- `.ai/workflows/revisar-codigo.md`

Agentes recomendados:
- `orchestrator`
- `qa`
- `security` si hay auth, secretos o datos sensibles
- `arquitecto` si hay impacto estructural

Enfoque correcto:
- Prioriza bugs, regresiones, seguridad y falta de pruebas.
- No conviertas la revision en una reescritura del cambio.

Prompt sugerido:
```text
Usa el workflow revisar-codigo.
Enfoque: identificar hallazgos por severidad, pruebas faltantes y riesgo residual.
Archivos o cambio objetivo: <ruta o descripcion>
```

## Escenario 5: Generar pruebas

Usalo cuando:
- El cambio no tiene cobertura suficiente.
- Se corrigio un bug y hace falta regresion.
- Quieres proponer la mejor capa de validacion.

Workflow principal:
- `.ai/workflows/generar-pruebas.md`

Agentes recomendados:
- `qa`
- `backend` o `frontend`

Archivos a revisar primero:
- Codigo afectado
- `.ai/pruebas/`
- `.ai/plantillas/flujo-prueba.md`

Resultado esperado:
- Casos de prueba claros.
- Nivel de cobertura justificado.
- Riesgos no cubiertos explicitados.

## Escenario 6: Investigar un bug

Usalo cuando:
- Hay un error reproducible o intermitente.
- No esta clara la causa.
- Hace falta aislar la capa afectada.

Workflow principal:
- `.ai/workflows/investigar-bug.md`

Agentes recomendados:
- `orchestrator`
- `qa`
- `backend`, `frontend`, `data` o `devops` segun indicios

Resultado esperado:
- Reproduccion minima.
- Hipotesis de causa.
- Caso de regresion propuesto.

Prompt sugerido:
```text
Usa el workflow investigar-bug.
Bug: <descripcion>
Esperado: <comportamiento esperado>
Observado: <comportamiento observado>
Entorno: <local/qa/prod>
```

## Escenario 7: Preparar release

Usalo cuando:
- El cambio debe desplegarse.
- Hay que validar version, riesgos y rollback.

Workflow principal:
- `.ai/workflows/preparar-release.md`

Agentes recomendados:
- `orchestrator`
- `devops`
- `qa`
- `security`
- `docs`

Archivos a revisar primero:
- `.ai/memoria/decisiones.md`
- `.ai/memoria/pendientes.md`
- `docs/runbooks/`

Resultado esperado:
- Release trazable.
- Validacion minima ejecutada.
- Rollback claro.

## Atajos de decision

Si no sabes por donde empezar:

- Si el repo es desconocido: onboarding.
- Si agregas capacidad: crear modulo.
- Si mejoras estructura: refactorizar.
- Si dudas de calidad: ejecutar QA o revisar codigo.
- Si hay fallo: investigar bug.
- Si vas a desplegar: preparar release.

## Checklist universal

Antes de cerrar cualquier tarea valida esto:

- Se uso el workflow correcto.
- La memoria relevante fue consultada.
- Intervinieron solo los agentes necesarios.
- Existe evidencia minima de validacion.
- Se actualizaron memoria y docs si hubo cambios reales.
