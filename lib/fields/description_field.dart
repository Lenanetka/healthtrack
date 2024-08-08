import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Description'),
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
