import 'package:flutter/material.dart';
import '../models/journal_models.dart';

class MealDropdown extends StatefulWidget {
  final String? initialMealType;
  final ValueChanged<String> onChanged;

  const MealDropdown(
      {this.initialMealType, required this.onChanged, super.key});

  @override
  MealDropdownState createState() => MealDropdownState();
}

class MealDropdownState extends State<MealDropdown> {
  String? _selectedMealType;

  @override
  void initState() {
    super.initState();
    _selectedMealType = widget.initialMealType ?? Meal.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedMealType,
      decoration: const InputDecoration(labelText: 'Meal'),
      onChanged: (String? value) {
        setState(() {
          _selectedMealType = value;
        });
        widget.onChanged(value!);
      },
      items: Meal.options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(Meal.nameByOption[value]!),
        );
      }).toList(),
    );
  }
}
