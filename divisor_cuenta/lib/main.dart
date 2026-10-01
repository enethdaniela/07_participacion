import 'package:flutter/material.dart';

import 'data/redondeo_exacto.dart';
import 'data/redondeo_hacia_arriba.dart';
import 'domain/calcular_division.dart';
import 'domain/estrategia_redondeo.dart';
import 'domain/validar_entrada.dart';
import 'presentation/divisor_controller.dart';
import 'presentation/pantalla_divisor.dart';

void main() {
  final estrategias = <ModoRedondeo, EstrategiaRedondeo>{
    ModoRedondeo.exacto: RedondeoExacto(),
    ModoRedondeo.haciaArriba: RedondeoHaciaArriba(),
  };
  final controller = DivisorController(
    calcularDivision: CalcularDivision(),
    validarEntrada: ValidarEntrada(),
  );

  runApp(
    DivisorCuentaApp(controller: controller, estrategias: estrategias),
  );
}

class DivisorCuentaApp extends StatelessWidget {
  const DivisorCuentaApp({
    super.key,
    required this.controller,
    required this.estrategias,
  });

  final DivisorController controller;
  final Map<ModoRedondeo, EstrategiaRedondeo> estrategias;

  @override
  Widget build(BuildContext context) {
    const verde = Color(0xFF176B55);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Divisor de cuenta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: verde),
        scaffoldBackgroundColor: const Color(0xFFF5F7F3),
        useMaterial3: true,
      ),
      home: PantallaDivisor(
        controller: controller,
        estrategias: estrategias,
      ),
    );
  }
}
