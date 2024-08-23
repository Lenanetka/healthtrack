import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/journal_models.dart';
import '../../models/journal_database.dart';

import '../../fields/datetime_picker.dart';
import '../../fields/description_field.dart';
import '../../fields/weight_field.dart';
import '../../fields/blood_sugar_field.dart';
import '../../fields/meal_dropdown.dart';

class EditEntryPage extends StatefulWidget {
  final Entry entry;
  final Future<void> Function(Entry entry) onEdited;
  final Future<void> Function(Entry entry) onDeleted;
  const EditEntryPage({
    super.key,
    required this.entry,
    required this.onEdited,
    required this.onDeleted,
  });

  @override
  State<EditEntryPage> createState() => _EditEntryPageState();
}

class _EditEntryPageState extends State<EditEntryPage> {
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
    _selectedDateTime = widget.entry.datetime;
    _contentController.text = widget.entry.content;
    _descriptionController.text = widget.entry.description;
  }

  Future<void> _save() async {
    EntryDB entry = EntryDB(
        id: widget.entry.id,
        datetime: _selectedDateTime,
        content: _contentController.text,
        description: _descriptionController.text,
        type: widget.entry.type);
    final db = Provider.of<JournalDatabase>(context, listen: false);
    await db.editJournalEntry(entry);
    widget.onEdited(entry);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    final db = JournalDatabase();
    await db.deleteJournalEntry(widget.entry.id ?? 0);
    widget.onDeleted(widget.entry);
    if (mounted) Navigator.pop(context);
  }

  Widget contentField() {
    switch (widget.entry.type) {
      case Entry.weight:
        return WeightField(controller: _contentController);
      case Entry.bloodsugar:
        return BloodSugarField(controller: _contentController);
      case Entry.meal:
        return MealDropdown(
          initialMealType: widget.entry.content,
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
        title: Text(Entry.nameByOption[widget.entry.type]!),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _delete,
          ),
        ],
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
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
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
