import 'package:flutter/material.dart';
import '../models/journal_models.dart';

class AddButton extends StatefulWidget {
  final void Function(String type) onAdd;
  const AddButton({super.key, required this.onAdd});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  void _add(String type) {
    Navigator.pop(context);
    widget.onAdd(type);
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Weight.ICON,
              title: Text(Weight.TITLE),
              onTap: () => _add(Weight.TYPE),
            ),
            ListTile(
              leading: Meal.ICON,
              title: Text(Meal.TITLE),
              onTap: () => _add(Meal.TYPE),
            ),
            ListTile(
              leading: BloodSugar.ICON,
              title: Text(BloodSugar.TITLE),
              onTap: () => _add(BloodSugar.TYPE),
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
