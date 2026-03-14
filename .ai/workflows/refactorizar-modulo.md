# Workflow: Refactorizar modulo

## Objetivo
Reducir complejidad o deuda tecnica sin cambiar el comportamiento observable esperado.

## Pasos
1. Identificar problema, alcance y riesgo del refactor.
2. Proteger comportamiento con pruebas existentes o de caracterizacion.
3. Ejecutar cambios pequenos y reversibles.
4. Validar contratos publicos, rendimiento y observabilidad.
5. Actualizar memoria si cambia la estructura interna relevante.

## Reglas
- No mezclar refactor y nuevas features salvo necesidad explicita.
- Elevar al arquitecto cualquier cambio de frontera entre modulos.

## Salidas
- Codigo mas claro o desacoplado.
- Evidencia de no regresion.
