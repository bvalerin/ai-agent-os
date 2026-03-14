# Convenciones

## Nomenclatura
- Carpetas tecnicas en minusculas.
- Archivos Markdown con nombres descriptivos y guiones.
- Workflows y prompts nombrados por objetivo, no por implementacion.

## Documentacion
- `.ai/` es fuente operativa.
- `docs/` es salida consolidada para consulta del equipo.
- Toda decision relevante debe reflejarse en `memoria/decisiones.md`.

## Trabajo con modulos
- Cada modulo debe tener responsabilidad unica y limites claros.
- Todo modulo nuevo debe aparecer en `memoria/modulos.md`.
- Todo cambio estructural debe validar impacto en pruebas, seguridad y despliegue.

## Calidad
- Preferir cambios pequenos y revisables.
- Registrar riesgo residual cuando no haya cobertura total.
- No cerrar bugs sin criterio de reproduccion o regresion.
