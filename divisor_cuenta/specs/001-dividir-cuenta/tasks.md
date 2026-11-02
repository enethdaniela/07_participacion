---
description: "Tareas para implementar la división de cuenta con propina y redondeo"
---

# Tareas: Dividir cuenta con propina y redondeo

**Documentos de entrada**: Diseño en `/specs/001-dividir-cuenta/`

**Prerequisitos**: `plan.md`, `spec.md`, `research.md`, `data-model.md` y
`contracts/pantalla-divisor.md`.

**Pruebas**: Requeridas por la especificación y la Constitución. Las pruebas unitarias y de
widget se crean antes de la implementación correspondiente.

**Organización**: Las tareas se agrupan por historia de usuario para que cada flujo pueda
implementarse y probarse de manera independiente.

## Formato

- Cada tarea tiene checkbox, identificador secuencial, etiquetas aplicables y una ruta exacta.
- `[P]` identifica trabajo paralelo en archivos independientes sin dependencia pendiente.
- `[US1]` y `[US2]` vinculan las tareas con las historias de `spec.md`.

## Fase 1: Preparación

**Propósito**: Preparar los directorios de la funcionalidad en la aplicación Flutter existente.

- [X] T001 Crear los directorios `lib/domain/`, `lib/data/` y `lib/presentation/` de acuerdo con `specs/001-dividir-cuenta/plan.md`.

## Fase 2: Fundamentos

**Propósito**: Establecer entidades y el contrato de estrategia que necesita el cálculo y ambas historias.

- [X] T002 [P] Crear la entidad Cuenta con monto decimal, personas enteras (mínimo 1) y porcentaje de propina decimal (incluye 0) en `lib/domain/cuenta.dart`.
- [X] T003 [P] Crear el tipo Resultado con el monto calculado por persona en `lib/domain/resultado.dart`.
- [X] T004 Definir EstrategiaRedondeo con un único método que recibe un pago y devuelve el pago redondeado en `lib/domain/estrategia_redondeo.dart`.
- [X] T005 Implementar ValidarEntrada para analizar monto y personas y producir los mensajes exactos para cero personas o monto no numérico en `lib/domain/validar_entrada.dart`.

**Punto de control**: Las entidades y abstracción de dominio están disponibles; el dominio no importa Flutter.

## Fase 3: Historia de usuario 1 - Calcular pago por persona (Prioridad: P1, MVP)

**Objetivo**: Permitir ingresar una cuenta válida y ver el monto por persona con el modo de redondeo seleccionado.

**Prueba independiente**: Ejecutar los cuatro casos válidos y comprobar que muestran 27.50, 30.00, 3.33 y 4.00 respectivamente.

### Pruebas de la historia de usuario 1

- [X] T006 [P] [US1] Traducir los cuatro casos válidos de `specs/001-dividir-cuenta/spec.md` a datos esperados en `test/casos_de_prueba.dart`.
- [X] T007 [US1] Crear pruebas de los casos válidos y sustitución de estrategias mediante el contrato de EstrategiaRedondeo en `test/division_test.dart`.
- [X] T008 [P] [US1] Crear la prueba de widget del cálculo 100, 4 personas, 10% que debe mostrar 27.50 en `test/pantalla_test.dart`.

### Implementación de la historia de usuario 1

- [X] T009 [P] [US1] Implementar RedondeoExacto como implementación sustituible de EstrategiaRedondeo en `lib/data/redondeo_exacto.dart`.
- [X] T010 [P] [US1] Implementar RedondeoHaciaArriba para llevar el pago individual al entero siguiente en `lib/data/redondeo_hacia_arriba.dart`.
- [X] T011 [US1] Implementar CalcularDivision para aplicar la propina al monto, dividir entre personas y delegar el redondeo sin inspeccionar clases concretas en `lib/domain/calcular_division.dart`.
- [X] T012 [US1] Implementar FormateadorMoneda para presentar el resultado con dos decimales en `lib/presentation/formateador_moneda.dart`.
- [X] T013 [US1] Implementar DivisorController con CalcularDivision y ValidarEntrada recibidos por constructor, sin dependencias concretas de data, y recibir la EstrategiaRedondeo elegida al calcular en `lib/presentation/divisor_controller.dart`.
- [X] T014 [US1] Crear PantallaDivisor con entradas para monto, personas, propina y modo; recibir estrategias mediante la abstracción de dominio, usar estado local con setState y presentar el cálculo en `lib/presentation/pantalla_divisor.dart`.
- [X] T015 [US1] Conectar la pantalla y construir las implementaciones concretas únicamente desde `lib/main.dart`.

**Punto de control**: Probar independientemente los cuatro cálculos válidos en dominio y el cálculo principal desde la pantalla.

## Fase 4: Historia de usuario 2 - Corregir entradas no válidas (Prioridad: P2)

**Objetivo**: Mostrar los mensajes exactos de error para 0 personas y monto no numérico, sin dejar visible un resultado.

**Prueba independiente**: Ejecutar ambos escenarios inválidos; comprobar el mensaje indicado y que no se muestre un pago.

### Pruebas de la historia de usuario 2

- [X] T016 [P] [US2] Añadir a los datos de prueba los casos de 0 personas y monto «abc» con los mensajes esperados en `test/casos_de_prueba.dart`.
- [X] T017 [US2] Añadir pruebas unitarias que validen exactamente los errores «Debe haber al menos una persona» y «Monto inválido», y que no calculen resultado, en `test/division_test.dart`.
- [X] T018 [P] [US2] Crear pruebas de widget para los errores de 0 personas y monto «abc», verificando que no aparece resultado, en `test/pantalla_test.dart`.

### Integración de la historia de usuario 2

- [X] T019 [US2] Integrar ValidarEntrada con DivisorController para mostrar el error y limpiar cualquier resultado previo cuando los datos no sean válidos en `lib/presentation/divisor_controller.dart`.
- [X] T020 [US2] Integrar el estado de error y la ausencia de resultado cuando corresponda en `lib/presentation/pantalla_divisor.dart`.

**Punto de control**: Probar ambos errores independientemente, sin resultado visible.

## Fase 5: Pulido y validación transversal

**Propósito**: Validar integración, análisis estático y construcción Android.

- [X] T021 [P] Revisar que `lib/domain/` no importe `package:flutter` en los archivos de `lib/domain/`.
- [X] T022 [P] Revisar que las instancias concretas RedondeoExacto y RedondeoHaciaArriba solo se creen en `lib/main.dart`.
- [X] T023 [P] Revisar que CalcularDivision no compruebe tipos concretos de EstrategiaRedondeo en `lib/domain/calcular_division.dart`.
- [X] T024 Ejecutar `flutter test` desde `divisor_cuenta/` y confirmar que pasan los seis casos, la sustitución de estrategias y las pruebas de widget.
- [X] T025 Ejecutar `flutter analyze` desde `divisor_cuenta/` y resolver cualquier issue atribuible a esta funcionalidad.
- [X] T026 Ejecutar `flutter build apk --debug` desde `divisor_cuenta/` y confirmar que se genera el APK.
- [X] T027 [P] Revisar que la app no use conexiones de red ni almacenamiento en base de datos y que no se hayan agregado dependencias externas en `pubspec.yaml` y `lib/`.

## Dependencias y orden de ejecución

- Fase 1 precede a Fase 2; Fase 2, incluida ValidarEntrada, bloquea el trabajo de ambas historias.
- US1 comienza tras Fase 2 y es independiente de US2 a nivel de requisitos.
- US2 también depende de la fundación; en la implementación secuencial se integra después
  de US1 para poder comprobar que los errores eliminan resultados ya existentes.
- El pulido y la validación transversal ocurren después de US1 y US2.
- Dentro de cada historia, las pruebas describen primero los resultados esperados; validar
  y ejecutar todas las pruebas una vez que existan las implementaciones necesarias.

## Oportunidades de paralelismo

- En Fase 2, T002, T003 y T004 modifican archivos distintos y pueden avanzar en paralelo;
  T005 depende de la entidad Cuenta creada en T002.
- En US1, T006 y T008 afectan archivos de prueba distintos y pueden prepararse en paralelo.
  T007 depende de los casos de T006. T009 y T010 son implementaciones separadas del mismo
  contrato y pueden desarrollarse en paralelo después de T004.
- En US2, T016 y T018 afectan archivos distintos y pueden prepararse en paralelo; T017 usa
  los datos de T016. Las revisiones arquitectónicas T021–T023 son independientes una vez que
  existe el código final.
- T027 puede realizarse en paralelo con las revisiones arquitectónicas una vez que exista el
  código final.

### Ejemplos de ejecución en paralelo

```text
Ejecutar T002, T003 y T004 en paralelo; después de T002 ejecutar T005.
En US1: ejecutar T006 y T008 en paralelo; después T007; tras T004 ejecutar T009 y T010
en paralelo.
En US2: ejecutar T016 y T018 en paralelo; después T017.
Tras terminar ambas historias: ejecutar T021, T022, T023 y T027 en paralelo.
```

## Estrategia de implementación

### MVP (solo historia de usuario 1)

1. Completar preparación y fundamentos.
2. Implementar y validar los cuatro escenarios válidos y la sustitución de estrategias.
3. Confirmar que la pantalla presenta el importe esperado con dos decimales.

### Entrega incremental

1. Completar US1 y demostrar el cálculo válido independientemente.
2. Añadir US2 para cubrir validación de 0 personas y monto no numérico.
3. Ejecutar la validación transversal, análisis estático y compilación Android.
