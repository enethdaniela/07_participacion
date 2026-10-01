import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:divisor_cuenta/main.dart';

void main() {
  testWidgets('calcula cuánto paga cada persona', (WidgetTester tester) async {
    await tester.pumpWidget(const DivisorCuentaApp());

    final campos = find.byType(TextField);
    await tester.enterText(campos.at(0), '80');
    await tester.enterText(campos.at(1), '4');
    await tester.tap(find.text('Calcular división'));
    await tester.pumpAndSettle();

    expect(find.text('\$20.00'), findsOneWidget);
  });
}
