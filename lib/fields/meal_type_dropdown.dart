import 'package:flutter/material.dart';

class MealTypeDropdown extends StatefulWidget {
  final String? initialMealType;
  final ValueChanged<String?>? onChanged;

  const MealTypeDropdown({this.initialMealType, this.onChanged, super.key});

  @override
  MealTypeDropdownState createState() => MealTypeDropdownState();
}

class MealTypeDropdownState extends State<MealTypeDropdown> {
  final List<String> mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  String? _selectedMealType;

  @override
  void initState() {
    super.initState();
    _selectedMealType = widget.initialMealType ?? mealTypes.first;
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
        widget.onChanged!(value);
      },
      items: mealTypes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
