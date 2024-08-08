import 'package:flutter/material.dart';

class EntryPage extends StatefulWidget {
  final String title;
  final bool isEditMode;
  final List<Widget> fields;
  final VoidCallback onSave;
  final VoidCallback? onDelete;

  const EntryPage({
    super.key,
    required this.title,
    required this.isEditMode,
    required this.fields,
    required this.onSave,
    this.onDelete,
  });

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (widget.isEditMode && widget.onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: widget.onDelete,
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
