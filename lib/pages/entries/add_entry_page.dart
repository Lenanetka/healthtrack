import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/journal_models.dart';
import '../../models/journal_database.dart';

import '../../fields/datetime_picker.dart';
import '../../fields/description_field.dart';
import '../../fields/weight_field.dart';
import '../../fields/blood_sugar_field.dart';
import '../../fields/meal_dropdown.dart';

class AddEntryPage extends StatefulWidget {
  final String type;
  final Future<void> Function(Entry entry) onAdded;
  const AddEntryPage({
    super.key,
    required this.type,
    required this.onAdded,
  });

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDateTime = DateTime.now();
  void _onDateTimeChanged(DateTime datetime) {
    setState(() {
      _selectedDateTime = datetime;
    });
  }

  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDateTime = DateTime.now();
    _contentController.text = Entry.defaultContents[widget.type]!;
    _descriptionController.text = '';
  }

  Future<void> _save() async {
    EntryDB entry = EntryDB(
        datetime: _selectedDateTime,
        content: _contentController.text,
        description: _descriptionController.text,
        type: widget.type);
    final db = Provider.of<JournalDatabase>(context, listen: false);
    entry.id = await db.addJournalEntry(entry);
    widget.onAdded(entry);
    if (mounted) Navigator.pop(context);
  }

  Widget contentField() {
    switch (widget.type) {
      case Entry.weight:
        return WeightField(controller: _contentController);
      case Entry.bloodsugar:
        return BloodSugarField(controller: _contentController);
      case Entry.meal:
        return MealDropdown(
          onChanged: (value) => _contentController.text = value,
        );
      default:
        return TextFormField(controller: _contentController);
    }
  }

  List<Widget> fields() {
    return [
      DateTimePicker(
        initialDateTime: _selectedDateTime,
        onDateTimeChanged: _onDateTimeChanged,
      ),
      contentField(),
      DescriptionField(controller: _descriptionController),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Entry.titles[widget.type]!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              ...fields(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _save();
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
    _contentController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
