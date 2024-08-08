import 'package:flutter/material.dart';
import '../pages/blood_sugar_page.dart';
import '../pages/meal_page.dart';
import '../pages/weight_page.dart';
import '../models/journal_entry.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  void _openPage(context, page){
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
              leading: Weight.staticIcon,
              title: const Text(Weight.name),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeightPage(isEditMode: false)),
                );
              },
            ),
            ListTile(
              leading: Meal.staticIcon,
              title: const Text(Meal.name),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MealPage(isEditMode: false)),
                );
              },
            ),
            ListTile(
              leading: BloodSugar.staticIcon,
              title: const Text(BloodSugar.name),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BloodSugarPage(isEditMode: false)),
                );
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



