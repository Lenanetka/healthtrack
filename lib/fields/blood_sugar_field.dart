import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BloodSugarField extends StatelessWidget {
  final TextEditingController controller;

  const BloodSugarField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Blood sugar (mmol/l)'),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        LengthLimitingTextInputFormatter(5),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your blood sugar';
        final double? bloodSugar = double.tryParse(value);
        if (bloodSugar == null || bloodSugar <= 0) return 'Please enter a valid blood sugar';
        return null;
      },
    );
  }
}
