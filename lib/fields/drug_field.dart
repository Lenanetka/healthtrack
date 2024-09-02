import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrugField extends StatelessWidget {
  final TextEditingController controller;

  const DrugField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Drug'),
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your drug name';
        return null;
      },
    );
  }
}
