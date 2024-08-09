import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/page_with_title.dart';

import '../fields/height_field.dart';
import '../fields/name_field.dart';
import '../fields/weight_field.dart';

import '../widgets/bmi_widget.dart';

class ProfilePage extends StatefulWidget implements PageWithTitle {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
  @override
  String get title => 'Profile';
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController(text: 'User');
  final TextEditingController _heightController = TextEditingController(text: '180');
  final TextEditingController _weightController = TextEditingController(text: '70');

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  _nameController.text = prefs.getString('name') ?? 'User';
  _heightController.text = (prefs.getDouble('height') ?? 180.0).toString();
  _weightController.text = (prefs.getDouble('weight') ?? 70.0).toString();
}

  Future<void> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setDouble('height', double.parse(_heightController.text));
    await prefs.setDouble('weight', double.parse(_weightController.text));
  }

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
                    save();
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
