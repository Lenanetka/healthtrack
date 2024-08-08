import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HeightField extends StatelessWidget {
  final TextEditingController controller;

  const HeightField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Height (cm)'),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your height';
        }
        final double? height = double.tryParse(value);
        if (height == null || height <= 0) {
          return 'Please enter a valid height';
        }
        return null;
      },
    );
  }
}
