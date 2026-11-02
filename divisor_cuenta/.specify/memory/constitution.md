# Constitución del Divisor de Cuenta

## Principios fundamentales

### I. Principio de responsabilidad única (SRP)
Cada clase DEBE tener una sola razón para cambiar. El cálculo NO DEBE validar entradas ni
formatear resultados; la validación y el formato son responsabilidades separadas.

### II. Principio abierto/cerrado (OCP)
Agregar una regla de redondeo NO DEBE requerir editar las clases de cálculo existentes. El
comportamiento de redondeo DEBE proporcionarse mediante una abstracción que admita nuevas
estrategias.

### III. Principio de sustitución de Liskov (LSP)
Cualquier implementación de una interfaz DEBE poder sustituir a otra sin que quien la use
tenga que comprobar el tipo concreto.

### IV. Principio de segregación de interfaces (ISP)
Las interfaces DEBEN ser pequeñas. Una clase NO DEBE depender de métodos que no utiliza.

### V. Principio de inversión de dependencias (DIP)
`presentation` DEBE depender de abstracciones de `domain` y NO DEBE depender de
implementaciones concretas de `data`.

## Arquitectura y seguridad

- La aplicación DEBE usar las capas `presentation`, `domain` y `data`.
- Las dependencias DEBEN seguir `presentation -> domain <- data`.
- `lib/domain/` DEBE ser Dart puro y NO DEBE importar `package:flutter`.
- `main.dart` DEBE ser el único lugar donde se instancian implementaciones concretas.
- NO SE DEBEN guardar secretos ni claves API en el repositorio.

## Calidad, pruebas y regla de la materia

- La funcionalidad crítica DEBE tener pruebas automatizadas.
- Los criterios de aceptación de cada especificación DEBEN convertirse en pruebas ejecutables.
- El estudiante DEBE poder explicar cada función generada por el agente: qué hace, por qué
  existe, qué recibe, qué devuelve y qué errores produce.

## Gobernanza

Esta constitución rige las decisiones de implementación y revisión del proyecto. Cambiar
estas reglas requiere la aprobación de la persona propietaria del proyecto, una justificación
documentada y una actualización de versión semántica: MAJOR para cambios incompatibles,
MINOR para reglas nuevas o ampliadas sustancialmente y PATCH para aclaraciones que no cambian
la intención. Los cambios al código de la aplicación DEBEN revisarse según estas reglas.

**Versión**: 1.0.0 | **Ratificada**: 2026-10-01 | **Última modificación**: 2026-10-01
