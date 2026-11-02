# Guía rápida de validación

## Requisitos previos

- Flutter SDK estable instalado.
- Ejecutar los comandos desde `divisor_cuenta/`.

## Preparar dependencias

```powershell
flutter pub get
```

## Validar reglas de dominio

```powershell
flutter test test/division_test.dart
```

Se espera que los seis escenarios de aceptación y la prueba de sustitución de estrategias
pasen sin requerir widgets.

## Validar interacción de la pantalla

```powershell
flutter test test/pantalla_test.dart
```

Se espera que los escenarios de cálculo correcto, 0 personas y monto «abc» presenten los
resultados o mensajes descritos en [el contrato de pantalla](contracts/pantalla-divisor.md).

## Revisiones generales y compilación Android

```powershell
flutter test
flutter analyze
flutter build apk --debug
```

Se espera que todas las pruebas pasen, el análisis no reporte issues y se genere el APK
debug de Android.

## Verificación arquitectónica

Desde la raíz del repositorio, revisar que:

- `lib/domain/` no importe `package:flutter`.
- Las instancias concretas de `RedondeoExacto` y `RedondeoHaciaArriba` se creen solo en
  `lib/main.dart`.
- `CalcularDivision` dependa de `EstrategiaRedondeo`, sin inspeccionar tipos concretos.
- El cálculo, la validación y el formato permanezcan en responsabilidades separadas.
- La app no dependa de servicios de red ni de almacenamiento en base de datos, y no se
  agreguen paquetes externos.

El detalle de entidades está en [data-model.md](data-model.md).
