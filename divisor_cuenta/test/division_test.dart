import 'package:divisor_cuenta/data/redondeo_exacto.dart';
import 'package:divisor_cuenta/data/redondeo_hacia_arriba.dart';
import 'package:divisor_cuenta/domain/calcular_division.dart';
import 'package:divisor_cuenta/domain/estrategia_redondeo.dart';
import 'package:divisor_cuenta/domain/validar_entrada.dart';
import 'package:flutter_test/flutter_test.dart';

import 'casos_de_prueba.dart';

void main() {
  final validador = ValidarEntrada();
  final calculador = CalcularDivision();
  final exacto = RedondeoExacto();
  final haciaArriba = RedondeoHaciaArriba();

  for (final caso in casos) {
    test(caso.nombre, () {
      if (caso.errorEsperado != null) {
        expect(
          () => validador.validar(
            monto: caso.monto,
            personas: caso.personas,
            propina: caso.propina,
          ),
          throwsA(
            isA<FormatException>().having(
              (error) => error.message,
              'mensaje',
              caso.errorEsperado,
            ),
          ),
        );
        return;
      }

      final cuenta = validador.validar(
        monto: caso.monto,
        personas: caso.personas,
        propina: caso.propina,
      );
      final EstrategiaRedondeo estrategia = switch (caso.modo) {
        ModoRedondeo.exacto => exacto,
        ModoRedondeo.haciaArriba => haciaArriba,
      };
      final resultado = calculador.calcular(cuenta, estrategia);

      expect(resultado.montoPorPersona, closeTo(caso.esperado!, 0.001));
    });
  }

  test('CalcularDivision acepta estrategias sustituibles sin inspeccionar tipos', () {
    final cuenta = validador.validar(
      monto: '10',
      personas: '3',
      propina: '0',
    );

    expect(
      calculador.calcular(cuenta, exacto).montoPorPersona,
      closeTo(10 / 3, 0.001),
    );
    expect(
      calculador.calcular(cuenta, haciaArriba).montoPorPersona,
      closeTo(4, 0.001),
    );
  });
}
