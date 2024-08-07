import 'package:flutter/material.dart';

class HeightField extends StatelessWidget {
  final TextEditingController controller;

  const HeightField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Height (cm)'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your height';
        }
        final int? height = int.tryParse(value);
        if (height == null || height <= 0) {
          return 'Please enter a valid height (whole number)';
        }
        return null;
      },
    );
  }
}
