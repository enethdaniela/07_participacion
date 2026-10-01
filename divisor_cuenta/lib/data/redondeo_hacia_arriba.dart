import 'dart:math' as math;

import '../domain/estrategia_redondeo.dart';

class RedondeoHaciaArriba implements EstrategiaRedondeo {
  @override
  double redondear(double valor) => math
      .max(0, valor)
      .ceilToDouble();
}
