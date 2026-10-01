import 'cuenta.dart';

class ValidarEntrada {
  Cuenta validar({
    required String monto,
    required String personas,
    required String propina,
  }) {
    final montoNumerico = double.tryParse(_normalizarDecimal(monto));
    if (montoNumerico == null || !montoNumerico.isFinite || montoNumerico < 0) {
      throw const FormatException('Monto inválido');
    }

    final cantidadPersonas = int.tryParse(personas.trim());
    if (cantidadPersonas == null || cantidadPersonas < 1) {
      throw const FormatException('Debe haber al menos una persona');
    }

    final porcentaje = propina.trim().isEmpty
        ? 0.0
        : double.tryParse(_normalizarDecimal(propina));
    if (porcentaje == null || !porcentaje.isFinite || porcentaje < 0) {
      throw const FormatException('Propina inválida');
    }

    return Cuenta(
      monto: montoNumerico,
      personas: cantidadPersonas,
      propina: porcentaje,
    );
  }

  String _normalizarDecimal(String valor) =>
      valor.trim().replaceAll(',', '.');
}
