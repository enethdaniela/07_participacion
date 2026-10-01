import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const DivisorCuentaApp());
}

class DivisorCuentaApp extends StatelessWidget {
  const DivisorCuentaApp({super.key});

  @override
  Widget build(BuildContext context) {
    const verde = Color(0xFF176B55);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Divide la cuenta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: verde),
        scaffoldBackgroundColor: const Color(0xFFF5F7F3),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF7F8F6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE6EAE5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: verde, width: 1.5),
          ),
        ),
      ),
      home: const PantallaDivisor(),
    );
  }
}

class PantallaDivisor extends StatefulWidget {
  const PantallaDivisor({super.key});

  @override
  State<PantallaDivisor> createState() => _PantallaDivisorState();
}

class _PantallaDivisorState extends State<PantallaDivisor> {
  final _montoController = TextEditingController();
  final _personasController = TextEditingController();

  double? _pagoPorPersona;
  String? _error;

  @override
  void dispose() {
    _montoController.dispose();
    _personasController.dispose();
    super.dispose();
  }

  void _calcular() {
    final monto = double.tryParse(
      _montoController.text.trim().replaceAll(',', '.'),
    );
    final personas = int.tryParse(_personasController.text.trim());

    setState(() {
      _pagoPorPersona = null;
      if (monto == null || !monto.isFinite || monto < 0) {
        _error = 'Ingresa un monto válido.';
      } else if (personas == null || personas < 1) {
        _error = 'El número de personas debe ser al menos 1.';
      } else {
        _error = null;
        _pagoPorPersona = monto / personas;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const verde = Color(0xFF176B55);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7F3),
        title: const Text(
          'Divide la cuenta',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: verde,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.receipt_long, color: Colors.white, size: 30),
                        SizedBox(height: 18),
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
                          'Ingresa los datos y calcula cuánto paga cada persona.',
                          style: TextStyle(
                            color: Color(0xFFD9EEE7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D18342B),
                          blurRadius: 18,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Detalles de la cuenta',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _CampoEntrada(
                          label: 'Monto total',
                          hint: 'Ej. 80.00',
                          prefixText: '\$ ',
                          controller: _montoController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9.,]'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        _CampoEntrada(
                          label: 'Personas',
                          hint: 'Ej. 4',
                          controller: _personasController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        const SizedBox(height: 20),
                        FilledButton.icon(
                          onPressed: _calcular,
                          icon: const Icon(Icons.calculate_outlined),
                          label: const Text('Calcular división'),
                          style: FilledButton.styleFrom(
                            backgroundColor: verde,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 14),
                          Text(
                            _error!,
                            style: const TextStyle(
                              color: Color(0xFFB3261E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_pagoPorPersona case final pago?) ...[
                    Container(
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
                            '\$${pago.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: verde,
                              fontSize: 38,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else if (_error == null) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'El resultado aparecerá aquí.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF68746E)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CampoEntrada extends StatelessWidget {
  const _CampoEntrada({
    required this.label,
    required this.hint,
    required this.controller,
    required this.keyboardType,
    required this.inputFormatters,
    this.prefixText,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(hintText: hint, prefixText: prefixText),
        ),
      ],
    );
  }
}
