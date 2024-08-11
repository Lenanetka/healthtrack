import 'package:flutter/material.dart';

import '../models/journal.dart';
import '../models/journal_database.dart';

import '../fields/datetime_picker.dart';
import '../fields/description_field.dart';
import '../fields/blood_sugar_field.dart';
import 'entry_page.dart';

class BloodSugarPage extends StatefulWidget {
  final bool isEditMode;
  final BloodSugar? entry;
  final VoidCallback onSave;
  final VoidCallback onDelete;
  const BloodSugarPage({
    super.key,
    required this.isEditMode,
    required this.entry,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<BloodSugarPage> createState() => _BloodSugarPageState();
}

class _BloodSugarPageState extends State<BloodSugarPage> {
  final TextEditingController _bloodSugarController = TextEditingController();
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
    _bloodSugarController.text = widget.entry?.content ?? '5';
    _descriptionController.text = widget.entry?.description ?? '';
  }

  Future<void> _save() async {
    BloodSugar entry = BloodSugar(
        id: widget.entry?.id,
        dateTime: _selectedDateTime,
        amount: double.parse(_bloodSugarController.text),
        description: _descriptionController.text);
    final db = JournalDatabase();
    await db.saveJournalEntry(entry);
    widget.onSave();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return EntryPage(
      title: 'Blood sugar',
      isEditMode: widget.isEditMode,
      entry: widget.entry,
      fields: [
        DateTimePicker(
          initialDateTime: _selectedDateTime,
          onDateTimeChanged: _onDateTimeChanged,
        ),
        BloodSugarField(controller: _bloodSugarController),
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
    _bloodSugarController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
