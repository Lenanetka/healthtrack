import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeightField extends StatelessWidget {
  final TextEditingController controller;

  const WeightField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Weight (kg)'),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        LengthLimitingTextInputFormatter(6),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your weight';
        }
        final double? weight = double.tryParse(value);
        if (weight == null || weight <= 0) {
          return 'Please enter a valid weight';
        }
        return null;
      },
    );
  }
}
