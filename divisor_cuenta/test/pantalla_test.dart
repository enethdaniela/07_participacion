import 'package:divisor_cuenta/data/redondeo_exacto.dart';
import 'package:divisor_cuenta/data/redondeo_hacia_arriba.dart';
import 'package:divisor_cuenta/domain/calcular_division.dart';
import 'package:divisor_cuenta/domain/estrategia_redondeo.dart';
import 'package:divisor_cuenta/domain/validar_entrada.dart';
import 'package:divisor_cuenta/main.dart';
import 'package:divisor_cuenta/presentation/divisor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _crearApp() {
  return DivisorCuentaApp(
    controller: DivisorController(
      calcularDivision: CalcularDivision(),
      validarEntrada: ValidarEntrada(),
    ),
    estrategias: <ModoRedondeo, EstrategiaRedondeo>{
      ModoRedondeo.exacto: RedondeoExacto(),
      ModoRedondeo.haciaArriba: RedondeoHaciaArriba(),
    },
  );
}

Future<void> _ingresar(
  WidgetTester tester, {
  required String monto,
  required String personas,
  String propina = '0',
}) async {
  await tester.enterText(find.byKey(const ValueKey('monto')), monto);
  await tester.enterText(find.byKey(const ValueKey('personas')), personas);
  await tester.enterText(find.byKey(const ValueKey('propina')), propina);
  await tester.ensureVisible(find.byKey(const ValueKey('calcular')));
  await tester.tap(find.byKey(const ValueKey('calcular')));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('calcula el pago de cada persona', (WidgetTester tester) async {
    await tester.pumpWidget(_crearApp());
    await _ingresar(tester, monto: '100', personas: '4', propina: '10');

    expect(find.text('\$27.50'), findsOneWidget);
  });

  testWidgets('cero personas muestra error sin resultado', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_crearApp());
    await _ingresar(tester, monto: '50', personas: '0');

    expect(find.text('Debe haber al menos una persona'), findsOneWidget);
    expect(find.byKey(const ValueKey('resultado')), findsNothing);
  });

  testWidgets('monto no numérico muestra error sin resultado', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_crearApp());
    await _ingresar(tester, monto: 'abc', personas: '4');

    expect(find.text('Monto inválido'), findsOneWidget);
    expect(find.byKey(const ValueKey('resultado')), findsNothing);
  });
}
