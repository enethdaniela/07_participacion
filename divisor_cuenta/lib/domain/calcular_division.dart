import 'cuenta.dart';
import 'estrategia_redondeo.dart';
import 'resultado.dart';

class CalcularDivision {
  Resultado calcular(Cuenta cuenta, EstrategiaRedondeo estrategia) {
    final montoConPropina = cuenta.monto * (1 + cuenta.propina / 100);
    final pagoSinRedondear = montoConPropina / cuenta.personas;
    return Resultado(
      montoPorPersona: estrategia.redondear(pagoSinRedondear),
    );
  }
}
