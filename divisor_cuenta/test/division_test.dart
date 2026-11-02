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
            monto: caso.monto.toString(),
            personas: caso.personas.toString(),
            propina: caso.propina.toString(),
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
        monto: caso.monto.toString(),
        personas: caso.personas.toString(),
        propina: caso.propina.toString(),
      );
      final EstrategiaRedondeo estrategia = switch (caso.modo) {
        'exacto' => exacto,
        'arriba' => haciaArriba,
        _ => throw StateError('Modo de redondeo desconocido: ${caso.modo}'),
      };
      final resultado = calculador.calcular(cuenta, estrategia);

      expect(resultado.montoPorPersona, closeTo(caso.esperado!, 0.005));
    });
  }

  test('ValidarEntrada rechaza una propina superior al 100%', () {
    expect(
      () => validador.validar(
        monto: '100',
        personas: '4',
        propina: '150',
      ),
      throwsA(
        isA<FormatException>().having(
          (error) => error.message,
          'mensaje',
          'La propina no puede superar el 100%',
        ),
      ),
    );
  });

  test('ValidarEntrada permite una propina de exactamente 100%', () {
    expect(
      () => validador.validar(
        monto: '100',
        personas: '4',
        propina: '100',
      ),
      returnsNormally,
    );
  });

  test(
    'CalcularDivision acepta estrategias sustituibles sin inspeccionar tipos',
    () {
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
    },
  );
}
