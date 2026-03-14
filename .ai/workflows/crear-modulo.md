# Workflow: Crear modulo

## Objetivo
Crear un modulo nuevo alineado con vision, arquitectura y convenciones del proyecto.

## Precondiciones
- Existe una necesidad concreta.
- Se revisaron `memoria/vision.md`, `memoria/arquitectura.md` y `memoria/convenciones.md`.

## Pasos
1. Delimitar responsabilidad, entradas, salidas y dependencias.
2. Redactar el modulo usando [`../plantillas/modulo-base.md`](../plantillas/modulo-base.md).
3. Validar ubicacion del modulo y contrato con arquitectura.
4. Implementar el esqueleto y luego el comportamiento principal.
5. Generar pruebas con [`generar-pruebas.md`](./generar-pruebas.md).
6. Documentar el modulo en `memoria/modulos.md`.
7. Solicitar revision con [`revisar-codigo.md`](./revisar-codigo.md).

## Salidas
- Modulo creado.
- Pruebas iniciales.
- Memoria y docs actualizadas.
