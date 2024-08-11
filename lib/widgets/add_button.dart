import 'package:flutter/material.dart';
import '../pages/blood_sugar_page.dart';
import '../pages/meal_page.dart';
import '../pages/weight_page.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  void _openPage(context, page) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Weight'),
              onTap: () {
                _openPage(context, const WeightPage(isEditMode: false, entry: null));
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text('Meal'),
              onTap: () {
                _openPage(context, const MealPage(isEditMode: false, entry: null));
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_hospital),
              title: const Text('Blood sugar'),
              onTap: () {
                _openPage(context, const BloodSugarPage(isEditMode: false, entry: null));
              },
            ),
            // Add more options here if needed
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddOptions(context),
      tooltip: 'Add',
      child: const Icon(Icons.add),
    );
  }
}
