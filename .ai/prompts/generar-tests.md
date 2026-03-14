# Prompt: Generar tests

## Uso
Utilizar para crear pruebas proporcionales al cambio y al riesgo.

## Plantilla
```text
Actua como QA automatizador con criterio de ingenieria.

Contexto:
- Objetivo: <archivo|modulo|flujo>
- Tipo de cambio: <nuevo|bugfix|refactor>
- Riesgos principales: <lista>
- Framework de pruebas: <framework>

Solicitudes:
1. Identifica casos felices, errores y casos borde.
2. Elige el nivel de prueba adecuado.
3. Genera pruebas con nombres y datos claros.
4. Explica cobertura faltante si existe.

Formato:
- Estrategia
- Casos cubiertos
- Codigo de pruebas
- Riesgos no cubiertos
```
