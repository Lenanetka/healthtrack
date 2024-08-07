import 'package:flutter/material.dart';

class WeightField extends StatelessWidget {
  final TextEditingController controller;

  const WeightField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Weight (kg)'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your weight';
        }
        final int? weight = int.tryParse(value);
        if (weight == null || weight <= 0) {
          return 'Please enter a valid weight (whole number)';
        }
        return null;
      },
    );
  }
}
