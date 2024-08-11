import 'package:flutter/material.dart';

import '../models/journal.dart';
import '../models/journal_database.dart';

import '../fields/datetime_picker.dart';
import '../fields/description_field.dart';
import '../fields/meal_dropdown.dart';
import 'entry_page.dart';

class MealPage extends StatefulWidget {
  final bool isEditMode;
  final Meal? entry;
  const MealPage({super.key, required this.isEditMode, required this.entry});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  String selectedMeal = 'Breakfast';
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
    selectedMeal = _defaultMeal();
  }

  Future<void> _save() async {
    Meal entry = Meal(
        id: widget.entry?.id,
        dateTime: _selectedDateTime,
        name: selectedMeal,
        description: _descriptionController.text);
    final db = JournalDatabase();
    await db.saveJournalEntry(entry);
    if (mounted) Navigator.pop(context);
  }

  String _defaultMeal(){
    return 'Breakfast';
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
          initialMealType: selectedMeal,
          onChanged: (value) {
            selectedMeal = value ?? _defaultMeal();
          },
        ),
        DescriptionField(controller: _descriptionController),
      ],
      onSave: () async {
        await _save();
      },
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
