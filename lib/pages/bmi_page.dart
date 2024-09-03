import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/page_with_title.dart';
import '../widgets/bmi_widget.dart';
import '../models/journal_models.dart';

import '../fields/height_field.dart';
import '../fields/weight_field.dart';

class BMIPage extends StatefulWidget implements PageWithTitle {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
  @override
  Icon get icon => const Icon(Icons.monitor_weight);
  @override
  String get title => 'BMI';
}

class _BMIPageState extends State<BMIPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _heightController = TextEditingController(text: '170');
  final TextEditingController _weightController = TextEditingController(text: Entry.defaultContents[Entry.weight]);

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _heightController.text = (prefs.getDouble('height') ?? 170.0).toString();
  }

  Future<void> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', double.parse(_heightController.text));
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
                      const SnackBar(content: Text('Saved')),
                    );
                  }
                },
                child: const Text('Save height'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
