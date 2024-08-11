import 'package:flutter/material.dart';

import '../../models/journal.dart';
import '../../models/journal_database.dart';

class EntryPage extends StatefulWidget {
  final String title;
  final bool isEditMode;
  final Journal? entry;
  final List<Widget> fields;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  const EntryPage({
    super.key,
    required this.title,
    required this.isEditMode,
    required this.entry,
    required this.fields,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _delete() async {
    if (widget.entry != null) {
      final db = JournalDatabase();
      await db.deleteJournalEntry(widget.entry!.id ?? 0);
      widget.onDelete();
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (widget.isEditMode)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await _delete();
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              ...widget.fields,
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSave();
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
}
