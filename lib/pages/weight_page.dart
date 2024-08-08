import 'package:flutter/material.dart';
import '../fields/datetime_picker.dart';
import '../fields/description_field.dart';
import '../fields/weight_field.dart';
import 'entry_page.dart';

class WeightPage extends StatefulWidget {
  final bool isEditMode;
  const WeightPage({super.key, required this.isEditMode});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final TextEditingController _weightController = TextEditingController(text: '70');
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
      title: 'Weight',
      isEditMode: widget.isEditMode,
      fields: [
        DateTimePicker(
          initialDateTime: _selectedDateTime,
          onDateTimeChanged: _onDateTimeChanged,
        ),
        WeightField(controller: _weightController),
        DescriptionField(controller: _descriptionController),
      ],
      onSave: _save,
      onDelete: widget.isEditMode ? _delete : null,
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }
}
