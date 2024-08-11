import 'package:flutter/material.dart';

import '../../models/journal.dart';
import '../../models/journal_database.dart';

import '../../fields/datetime_picker.dart';
import '../../fields/description_field.dart';
import '../../fields/meal_dropdown.dart';
import 'entry_page.dart';

class MealPage extends StatefulWidget {
  final bool isEditMode;
  final Meal? entry;
  final VoidCallback onSave;
  final VoidCallback onDelete;
  const MealPage({
    super.key,
    required this.isEditMode,
    required this.entry,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  String _selectedMeal = 'Breakfast';
  void _onMealChanged(String? name) {
    setState(() {
      _selectedMeal = name ?? 'Breakfast';
    });
  }
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
    _selectedMeal = widget.entry?.content ?? 'Breakfast';
    _descriptionController.text = widget.entry?.description ?? '';
  }

  Future<void> _save() async {
    Meal entry = Meal(
        id: widget.entry?.id,
        dateTime: _selectedDateTime,
        name: _selectedMeal,
        description: _descriptionController.text);
    final db = JournalDatabase();
    await db.saveJournalEntry(entry);
    widget.onSave();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return EntryPage(
      title: 'Meal',
      isEditMode: widget.isEditMode,
      entry: widget.entry,
      fields: [
        DateTimePicker(
          initialDateTime: _selectedDateTime,
          onDateTimeChanged: _onDateTimeChanged,
        ),
        MealDropdown(
          initialMealType: _selectedMeal,
          onChanged: (value) => _onMealChanged(value),
        ),
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
    _descriptionController.dispose();
    super.dispose();
  }
}
