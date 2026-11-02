import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:divisor_cuenta/main.dart';

void main() {
  testWidgets('reparte monto y propina en modo exacto', (tester) async {
    await _calcular(tester, monto: '100', personas: '4', propina: '10');
    expect(find.text('\$27.50'), findsOneWidget);
  });

  testWidgets('reparte sin propina en modo exacto', (tester) async {
    await _calcular(tester, monto: '90', personas: '3', propina: '0');
    expect(find.text('\$30.00'), findsOneWidget);
  });

  testWidgets('cero personas muestra el error sin resultado', (tester) async {
    await _calcular(tester, monto: '50', personas: '0', propina: '0');
    expect(find.text('Debe haber al menos una persona'), findsOneWidget);
    expect(_findPayment(), findsNothing);
  });

  testWidgets('monto no numérico muestra el error sin resultado', (
    tester,
  ) async {
    await _calcular(tester, monto: 'abc', personas: '4', propina: '0');
    expect(find.text('Monto inválido'), findsOneWidget);
    expect(_findPayment(), findsNothing);
  });

  testWidgets('muestra dos decimales en modo exacto', (tester) async {
    await _calcular(tester, monto: '10', personas: '3', propina: '0');
    expect(find.text('\$3.33'), findsOneWidget);
  });

  testWidgets('redondea hacia arriba al entero siguiente', (tester) async {
    await _calcular(
      tester,
      monto: '10',
      personas: '3',
      propina: '0',
      haciaArriba: true,
    );
    expect(find.text('\$4.00'), findsOneWidget);
  });
}

Future<void> _calcular(
  WidgetTester tester, {
  required String monto,
  required String personas,
  required String propina,
  bool haciaArriba = false,
}) async {
  await tester.pumpWidget(const DivisorCuentaApp());
  final campos = find.byType(TextField);
  await tester.enterText(campos.at(0), monto);
  await tester.enterText(campos.at(1), personas);
  await tester.enterText(campos.at(2), propina);

  if (haciaArriba) {
    final selector = find.byKey(const Key('modo-redondeo'));
    await tester.ensureVisible(selector);
    await tester.tap(selector);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hacia arriba').last);
    await tester.pumpAndSettle();
  }

  final boton = find.text('Calcular división');
  await tester.ensureVisible(boton);
  await tester.tap(boton);
  await tester.pumpAndSettle();
}

Finder _findPayment() {
  return find.byWidgetPredicate(
    (widget) =>
        widget is Text &&
        widget.data != null &&
        RegExp(r'^\$\d+\.\d{2}$').hasMatch(widget.data!),
  );
}
