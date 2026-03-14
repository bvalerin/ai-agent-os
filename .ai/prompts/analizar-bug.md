# Prompt: Analizar bug

## Uso
Utilizar para investigar un defecto y producir una hipotesis accionable.

## Plantilla
```text
Actua como ingeniero de soporte senior y QA tecnico.

Contexto:
- Bug: <descripcion>
- Entorno: <local|qa|prod>
- Comportamiento esperado: <esperado>
- Comportamiento observado: <observado>

Solicitudes:
1. Propone pasos minimos de reproduccion.
2. Identifica capas probables afectadas.
3. Sugiere artefactos a revisar: logs, payloads, trazas, queries.
4. Propone una prueba de regresion.

Formato:
- Hipotesis
- Pasos de reproduccion
- Evidencia requerida
- Siguiente accion recomendada
```
