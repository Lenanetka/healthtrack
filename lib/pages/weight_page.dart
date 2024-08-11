import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/journal.dart';
import '../models/journal_database.dart';

import '../fields/datetime_picker.dart';
import '../fields/description_field.dart';
import '../fields/weight_field.dart';
import 'entry_page.dart';

class WeightPage extends StatefulWidget {
  final bool isEditMode;
  final Weight? entry;
  final VoidCallback onSave;
  final VoidCallback onDelete;
  const WeightPage({
    super.key,
    required this.isEditMode,
    required this.entry,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();
  void _onDateTimeChanged(DateTime datetime) {
    setState(() {
      _selectedDateTime = datetime;
    });
  }
  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.entry?.dateTime ?? DateTime.now();
    _weightController.text = widget.entry?.content ?? '70';
    _descriptionController.text = widget.entry?.description ?? '';
  }

  Future<void> _save() async {
    Weight entry = Weight(
        id: widget.entry?.id,
        dateTime: _selectedDateTime,
        amount: double.parse(_weightController.text),
        description: _descriptionController.text);
    final db = Provider.of<JournalDatabase>(context, listen: false);
    await db.saveJournalEntry(entry);
    widget.onSave();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return EntryPage(
      title: 'Weight',
      isEditMode: widget.isEditMode,
      entry: widget.entry,
      fields: [
        DateTimePicker(
          initialDateTime: _selectedDateTime,
          onDateTimeChanged: _onDateTimeChanged,
        ),
        WeightField(controller: _weightController),
        DescriptionField(controller: _descriptionController),
      ],
      onSave: () async {
        await _save();
      },
      onDelete: () => widget.onDelete(),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
