import 'package:flutter/material.dart';
import '../fields/datetime_picker.dart';
import '../fields/description_field.dart';
import '../fields/blood_sugar_field.dart';
import 'entry_page.dart';

class BloodSugarPage extends StatefulWidget {
  final bool isEditMode;
  const BloodSugarPage({super.key, required this.isEditMode});

  @override
  State<BloodSugarPage> createState() => _BloodSugarPageState();
}

class _BloodSugarPageState extends State<BloodSugarPage> {
  final TextEditingController _bloodSugarController = TextEditingController(text: '5');
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
      title: 'Blood sugar',
      isEditMode: widget.isEditMode,
      fields: [
        DateTimePicker(
          initialDateTime: _selectedDateTime,
          onDateTimeChanged: _onDateTimeChanged,
        ),
        BloodSugarField(controller: _bloodSugarController),
        DescriptionField(controller: _descriptionController),
      ],
      onSave: _save,
      onDelete: widget.isEditMode ? _delete : null,
    );
  }

  @override
  void dispose() {
    _bloodSugarController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
