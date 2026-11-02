# Respuestas — Deber 3

1. **Rojo antes de verde.** La prueba esperaba que la validación lanzara `FormatException` con el mensaje `La propina no puede superar el 100%`, pero en la versión sin la regla devolvió una `Cuenta`. Verla fallar confirma que la prueba detecta el comportamiento que se quería agregar.

2. **Linter vs. IA.** Al agregar temporalmente los ejemplos, `flutter analyze` reportó `unused_local_variable` para una variable sin uso y `avoid_print` para `print('hola')`. El code smell elegido fue que `build` concentraba demasiado código de interfaz. El linter no lo señaló porque esa complejidad es válida sintácticamente y requiere valorar la estructura y legibilidad del código.

3. **Refactorización.** Se extrajeron del método `build` los bloques del encabezado, formulario y resultado a `_construirEncabezado`, `_construirFormulario` y `_construirResultado`. Las pruebas de dominio y de pantalla siguen pasando, lo que comprueba los comportamientos que cubren sin cambiar sus resultados.

4. **Coverage.** `lib/main.dart` tuvo el porcentaje menor: **47,06 %** de líneas. Eso no significa que tenga errores; coverage indica qué líneas ejecutaron las pruebas, no si el código es correcto.
