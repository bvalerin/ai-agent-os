# Workflow: Ejecutar QA

## Objetivo
Ejecutar la validacion adecuada al cambio y producir un reporte accionable.

## Pasos
1. Detectar stack y runners disponibles.
2. Ejecutar unit e integracion del area afectada.
3. Ejecutar API, E2E o performance si el cambio lo requiere.
4. Registrar fallas, tiempos y bloqueos del entorno.
5. Emitir reporte usando [`../plantillas/reporte-qa.md`](../plantillas/reporte-qa.md).

## Salidas
- Reporte de QA.
- Lista de fallas encontradas.
- Recomendacion de salida.
