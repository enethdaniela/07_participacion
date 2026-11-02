import '../domain/calcular_division.dart';
import '../domain/cuenta.dart';
import '../domain/estrategia_redondeo.dart';
import '../domain/resultado.dart';
import '../domain/validar_entrada.dart';

class DivisorController {
  DivisorController({
    required this._calcularDivision,
    required this._validarEntrada,
  });

  final CalcularDivision _calcularDivision;
  final ValidarEntrada _validarEntrada;

  Resultado? resultado;
  String? error;

  void calcular({
    required String monto,
    required String personas,
    required String propina,
    required EstrategiaRedondeo estrategia,
  }) {
    resultado = null;
    error = null;

    try {
      final Cuenta cuenta = _validarEntrada.validar(
        monto: monto,
        personas: personas,
        propina: propina,
      );
      resultado = _calcularDivision.calcular(cuenta, estrategia);
    } on FormatException catch (excepcion) {
      error = excepcion.message.toString();
    }
  }
}
