import 'package:flutter/material.dart';
import '../models/page_with_title.dart';

import '../fields/height_field.dart';
import '../fields/name_field.dart';
import '../fields/weight_field.dart';

import '../widgets/bmi_widget.dart';

class Profile extends StatefulWidget implements PageWithTitle {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
  @override
  String get title => 'Profile';
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController(text: 'User');
  final TextEditingController _heightController = TextEditingController(text: '180');
  final TextEditingController _weightController = TextEditingController(text: '70');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              NameField(controller: _nameController),
              HeightField(controller: _heightController),
              WeightField(controller: _weightController),
              const SizedBox(height: 20),
              BMIWidget(
                heightController: _heightController,
                weightController: _weightController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform save operation
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile saved')),
                    );
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
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
