import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../domain/estrategia_redondeo.dart';
import '../domain/resultado.dart';
import 'divisor_controller.dart';
import 'formateador_moneda.dart';

class PantallaDivisor extends StatefulWidget {
  const PantallaDivisor({
    super.key,
    required this.controller,
    required this.estrategias,
  });

  final DivisorController controller;
  final Map<ModoRedondeo, EstrategiaRedondeo> estrategias;

  @override
  State<PantallaDivisor> createState() => _PantallaDivisorState();
}

class _PantallaDivisorState extends State<PantallaDivisor> {
  final _montoController = TextEditingController();
  final _personasController = TextEditingController();
  final _propinaController = TextEditingController(text: '0');
  final _formateador = FormateadorMoneda();
  ModoRedondeo _modo = ModoRedondeo.exacto;

  @override
  void dispose() {
    _montoController.dispose();
    _personasController.dispose();
    _propinaController.dispose();
    super.dispose();
  }

  void _calcular() {
    setState(() {
      widget.controller.calcular(
        monto: _montoController.text,
        personas: _personasController.text,
        propina: _propinaController.text,
        estrategia: widget.estrategias[_modo]!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const verde = Color(0xFF176B55);
    final resultado = widget.controller.resultado;
    final error = widget.controller.error;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Divide la cuenta',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7F3),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _construirEncabezado(verde),
                  const SizedBox(height: 18),
                  _construirFormulario(error, verde),
                  if (resultado != null) _construirResultado(resultado, verde),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _construirEncabezado(Color verde) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: verde,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.receipt_long, color: Colors.white, size: 30),
          SizedBox(height: 16),
          Text(
            'Una cuenta,\nentre todos.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              height: 1.15,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Calcula cuánto paga cada persona.',
            style: TextStyle(color: Color(0xFFD9EEE7)),
          ),
        ],
      ),
    );
  }

  Widget _construirFormulario(String? error, Color verde) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Detalles de la cuenta',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          _CampoEntrada(
            campoKey: const ValueKey('monto'),
            controller: _montoController,
            etiqueta: 'Monto total',
            pista: 'Ej. 100.00',
            prefijo: '\$ ',
            teclado: const TextInputType.numberWithOptions(decimal: true),
            formato: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _CampoEntrada(
                  campoKey: const ValueKey('personas'),
                  controller: _personasController,
                  etiqueta: 'Personas',
                  pista: 'Ej. 4',
                  teclado: TextInputType.number,
                  formato: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _CampoEntrada(
                  campoKey: const ValueKey('propina'),
                  controller: _propinaController,
                  etiqueta: 'Propina',
                  pista: '0',
                  sufijo: '%',
                  teclado: const TextInputType.numberWithOptions(decimal: true),
                  formato: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Modo de redondeo',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          SegmentedButton<ModoRedondeo>(
            segments: const [
              ButtonSegment(value: ModoRedondeo.exacto, label: Text('Exacto')),
              ButtonSegment(
                value: ModoRedondeo.haciaArriba,
                label: Text('Hacia arriba'),
              ),
            ],
            selected: {_modo},
            onSelectionChanged: (seleccion) {
              setState(() => _modo = seleccion.first);
            },
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            key: const ValueKey('calcular'),
            onPressed: _calcular,
            icon: const Icon(Icons.calculate_outlined),
            label: const Text('Calcular'),
            style: FilledButton.styleFrom(
              backgroundColor: verde,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          if (error != null) ...[
            const SizedBox(height: 14),
            Text(
              error,
              key: const ValueKey('error'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFB3261E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _construirResultado(Resultado resultado, Color verde) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        key: const ValueKey('resultado'),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFFE6F2EC),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            const Text(
              'CADA PERSONA PAGA',
              style: TextStyle(
                color: Color(0xFF47685D),
                fontSize: 12,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${_formateador.formatear(resultado.montoPorPersona)}',
              style: TextStyle(
                color: verde,
                fontSize: 38,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CampoEntrada extends StatelessWidget {
  const _CampoEntrada({
    required this.controller,
    required this.etiqueta,
    required this.pista,
    required this.teclado,
    required this.formato,
    this.campoKey,
    this.prefijo,
    this.sufijo,
  });

  final Key? campoKey;
  final TextEditingController controller;
  final String etiqueta;
  final String pista;
  final TextInputType teclado;
  final List<TextInputFormatter> formato;
  final String? prefijo;
  final String? sufijo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(etiqueta, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          key: campoKey,
          controller: controller,
          keyboardType: teclado,
          inputFormatters: formato,
          decoration: InputDecoration(
            hintText: pista,
            prefixText: prefijo,
            suffixText: sufijo,
            filled: true,
            fillColor: const Color(0xFFF7F8F6),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ],
    );
  }
}
