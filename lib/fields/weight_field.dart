import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/journal_models.dart';
import '../models/journal_database.dart';

class WeightField extends StatefulWidget {
  const WeightField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  State<WeightField> createState() => _WeightFieldState();
}

class _WeightFieldState extends State<WeightField> {
  late JournalDatabase _db;

  @override
  void initState() {
    super.initState();
    _db = Provider.of<JournalDatabase>(context, listen: false);
    _loadLastWeight();
  }

  Future<void> _loadLastWeight() async {
    final defaultWeight = Entry.defaultContents[Entry.weight]!;
    if (widget.controller.text.isEmpty ||
        widget.controller.text == defaultWeight) {
      final entries =
          await _db.getJournalFiltered(DateTime.now(), Entry.weight);
      widget.controller.text =
          entries.isEmpty ? defaultWeight : entries.first.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
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
