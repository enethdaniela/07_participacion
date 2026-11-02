# Plan de implementación: Dividir cuenta con propina y redondeo

**Rama**: `sdd` | **Fecha**: 2026-10-01 | **Spec**: [spec.md](spec.md)

**Entrada**: Especificación de funcionalidad en `specs/001-dividir-cuenta/spec.md`

## Resumen

Construir una sola pantalla que recibe monto, número de personas, porcentaje de propina y
modo de redondeo, valida los datos, calcula el pago individual y lo presenta con dos
decimales. La app funcionará sin red ni base de datos. El código se organizará en las capas
`presentation`, `domain` y `data`; se usará Flutter estable, sin agregar paquetes, y el
estado de la pantalla se administrará con `setState`.

## Contexto técnico

**Lenguaje/versión**: Dart con null safety; Flutter SDK estable. Entorno disponible al
planificar: Flutter 3.47.1 y Dart 3.13.1.

**Dependencias principales**: Flutter SDK y dependencias ya declaradas en `pubspec.yaml`.
No agregar paquetes externos.

**Almacenamiento**: Ninguno.

**Pruebas**: `flutter_test`; pruebas unitarias de dominio para los seis escenarios y la
sustitución de estrategias; pruebas de widgets para los tres flujos indicados en la guía.

**Plataforma destino**: Aplicación Flutter de una pantalla; verificación de compilación
Android con `flutter build apk --debug`.

**Tipo de proyecto**: Aplicación móvil Flutter, local y sin conexión.

**Metas de rendimiento**: El cálculo de una cuenta se ejecuta localmente al solicitarlo y
debe actualizar el resultado sin operaciones de red. No se requiere una meta de carga o
concurrencia.

**Restricciones**: Una pantalla; sin red, base de datos ni paquetes nuevos; dependencias
`presentation -> domain <- data`; `lib/domain/` no importa Flutter; solo `main.dart`
construye implementaciones concretas.

**Alcance**: seis escenarios de aceptación, dos estrategias de redondeo, cinco componentes
principales de dominio, dos implementaciones de redondeo y una pantalla con estado local.

## Verificación de la constitución

| Regla | Resultado de planificación |
|---|---|
| SRP | Validación, cálculo, redondeo, formato y presentación serán responsabilidades separadas. |
| OCP | `CalcularDivision` recibirá `EstrategiaRedondeo`; agregar otra estrategia no requerirá modificar el cálculo. |
| LSP | `RedondeoExacto` y `RedondeoHaciaArriba` implementarán el mismo contrato sustituible. |
| ISP | `EstrategiaRedondeo` expondrá un único método para redondear el pago individual. |
| DIP | El controlador dependerá de los casos de uso y la abstracción de dominio, no de las clases concretas `data`. |
| Capas | `presentation`, `domain` y `data`, con dependencias `presentation -> domain <- data`. |
| Pureza del dominio | Los archivos de `lib/domain/` solo dependerán de Dart. |
| Composición | `main.dart` será el único lugar que instancie implementaciones concretas. |
| Pruebas | Cada criterio de aceptación se representará en pruebas ejecutables. |
| Seguridad | No se usarán ni almacenarán secretos o claves API. |
| Regla de la materia | La implementación deberá poder explicarse en cuanto a propósito, entradas, salidas y errores. |

**Gate inicial**: PASS. El plan sigue las restricciones de la Constitución y el alcance de
la especificación; no se justifican excepciones.

**Gate posterior al diseño**: PASS. El modelo, el contrato y la guía conservan las capas,
mantienen Dart puro en dominio y asignan la composición únicamente a `main.dart`.

## Estructura del proyecto

### Documentación de esta funcionalidad

```text
specs/001-dividir-cuenta/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── pantalla-divisor.md
├── checklists/
│   ├── requirements.md
│   └── arquitectura.md
└── tasks.md
```

`tasks.md` se generará en la Parte 7.3 con `/speckit-tasks`.

### Código fuente

```text
lib/
├── domain/
│   ├── cuenta.dart
│   ├── resultado.dart
│   ├── estrategia_redondeo.dart
│   ├── calcular_division.dart
│   └── validar_entrada.dart
├── data/
│   ├── redondeo_exacto.dart
│   └── redondeo_hacia_arriba.dart
├── presentation/
│   ├── divisor_controller.dart
│   ├── formateador_moneda.dart
│   └── pantalla_divisor.dart
└── main.dart

test/
├── casos_de_prueba.dart
├── division_test.dart
└── pantalla_test.dart
```

**Decisión de estructura**: Se adopta la estructura de capas de la Constitución y del
enunciado del plan. `main.dart` realiza la composición; `DivisorController` recibe los
casos de uso y la estrategia por constructor. La pantalla conserva su estado con
`setState`, sin incorporar paquetes de gestión de estado.

## Complejidad

No hay excepciones a la Constitución ni componentes adicionales a los requeridos.
