# Instrucciones del proyecto

- Descripción: app Flutter de una sola pantalla para dividir una cuenta.
- Estructura: `lib/presentation`, `lib/domain` y `lib/data`.
- Dependencias: `presentation` depende de `domain`; `data` implementa abstracciones de `domain`. `domain` no importa `package:flutter`.
- Estándares: usa null safety, nombres en español y no agregues paquetes externos.
- No modifiques `test/` sin que te lo pidan, no agregues dependencias a `pubspec.yaml` sin avisar y no toques `android/` ni `ios/`.
- Comandos útiles: `flutter pub get`, `flutter run`, `flutter analyze` y `flutter test`.
