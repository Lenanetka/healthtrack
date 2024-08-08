import 'package:flutter/material.dart';
import '../fields/datetime_picker.dart';
import '../fields/description_field.dart';
import '../fields/meal_type_dropdown.dart';
import 'entry_page.dart';

class MealPage extends StatefulWidget {
  final bool isEditMode;
  const MealPage({super.key, required this.isEditMode});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  String? selectedMeal;
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();
  void _onDateTimeChanged(DateTime datetime) {
    setState(() {
      _selectedDateTime = datetime;
    });
  }

  void _save() {
    // Perform save opration here
    Navigator.pop(context);
  }

  void _delete() {
    // Perform delete operation here
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return EntryPage(
      title: 'Meal',
      isEditMode: widget.isEditMode,
      fields: [
        DateTimePicker(
          initialDateTime: _selectedDateTime,
          onDateTimeChanged: _onDateTimeChanged,
        ),
        MealTypeDropdown(
          initialMealType: selectedMeal,
          onChanged: (value) {
            selectedMeal = value;
          },
        ),
        DescriptionField(controller: _descriptionController),
      ],
      onSave: _save,
      onDelete: widget.isEditMode ? _delete : null,
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
