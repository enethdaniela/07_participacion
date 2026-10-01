import 'package:divisor_cuenta/domain/estrategia_redondeo.dart';

class CasoDivision {
  const CasoDivision({
    required this.nombre,
    required this.monto,
    required this.personas,
    required this.propina,
    required this.modo,
    this.esperado,
    this.errorEsperado,
  });

  final String nombre;
  final String monto;
  final String personas;
  final String propina;
  final ModoRedondeo modo;
  final double? esperado;
  final String? errorEsperado;
}

const casos = <CasoDivision>[
  CasoDivision(
    nombre: '1. reparto normal',
    monto: '100.00',
    personas: '4',
    propina: '10',
    modo: ModoRedondeo.exacto,
    esperado: 27.50,
  ),
  CasoDivision(
    nombre: '2. sin propina',
    monto: '90.00',
    personas: '3',
    propina: '0',
    modo: ModoRedondeo.exacto,
    esperado: 30.00,
  ),
  CasoDivision(
    nombre: '3. cero personas',
    monto: '50.00',
    personas: '0',
    propina: '0',
    modo: ModoRedondeo.exacto,
    errorEsperado: 'Debe haber al menos una persona',
  ),
  CasoDivision(
    nombre: '4. monto no numerico',
    monto: 'abc',
    personas: '4',
    propina: '0',
    modo: ModoRedondeo.exacto,
    errorEsperado: 'Monto inválido',
  ),
  CasoDivision(
    nombre: '5. redondeo exacto',
    monto: '10.00',
    personas: '3',
    propina: '0',
    modo: ModoRedondeo.exacto,
    esperado: 10 / 3,
  ),
  CasoDivision(
    nombre: '6. redondeo hacia arriba',
    monto: '10.00',
    personas: '3',
    propina: '0',
    modo: ModoRedondeo.haciaArriba,
    esperado: 4.00,
  ),
];
