import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/journal_models.dart';
import '../models/journal_database.dart';

class DrugField extends StatefulWidget {
  final TextEditingController controller;

  const DrugField({required this.controller, super.key});

  @override
  State<DrugField> createState() => _DrugFieldState();
}

class _DrugFieldState extends State<DrugField> {
  late JournalDatabase _db;
  @override
  void initState() {
    super.initState();
    _db = Provider.of<JournalDatabase>(context, listen: false);
    _loadLastWeight();
  }

  Future<void> _loadLastWeight() async {
    final defaultDrug = Entry.defaultContents[Entry.drug]!;
    if (widget.controller.text.isEmpty || widget.controller.text == defaultDrug) {
      final entries = await _db.getJournalByDateType(DateTime.now(), Entry.drug);
      widget.controller.text = entries.isEmpty ? defaultDrug : entries.first.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: const InputDecoration(labelText: 'Drug'),
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your drug name';
        return null;
      },
    );
  }
}
