import '../domain/estrategia_redondeo.dart';

class RedondeoExacto implements EstrategiaRedondeo {
  @override
  double redondear(double valor) => valor;
}
