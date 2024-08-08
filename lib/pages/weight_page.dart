import 'package:flutter/material.dart';
import '../fields/datetime_picker.dart';
import '../fields/weight_field.dart';

class WeightPage extends StatefulWidget {
  final bool isEditMode;
  const WeightPage({super.key, required this.isEditMode});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _weightController = TextEditingController(text: '70');
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _onDateTimeChanged(DateTime date, TimeOfDay time) {
    setState(() {
      _selectedDate = date;
      _selectedTime = time;
    });
  }

  DateTime _combineDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void _saveWeight() {
    final double? weight = double.tryParse(_weightController.text);
    if (weight != null && weight > 0) {
      DateTime combinedDateTime = _combineDateTime(_selectedDate, _selectedTime);
      // Perform save opration here
      Navigator.pop(context);
    }
  }

  void _deleteWeight() {
    // Perform delete operation here
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight'),
        actions: [
          if (widget.isEditMode) IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteWeight,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DateTimePicker(
                  initialDate: _selectedDate,
                  initialTime: _selectedTime,
                  onDateTimeChanged: _onDateTimeChanged),
              WeightField(controller: _weightController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveWeight();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }
}
