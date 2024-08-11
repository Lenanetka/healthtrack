import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final VoidCallback onAddWeight;
  final VoidCallback onAddMeal;
  final VoidCallback onAddBloodSugar;
  const AddButton({
    super.key,
    required this.onAddWeight,
    required this.onAddMeal,
    required this.onAddBloodSugar,
  });

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  void _addWeight() {
    Navigator.pop(context);
    widget.onAddWeight();
  }

  void _addMeal() {
    Navigator.pop(context);
    widget.onAddMeal();
  }

  void _addBloodSugar() {
    Navigator.pop(context);
    widget.onAddBloodSugar();
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
              onTap: _addWeight,
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text('Meal'),
              onTap: _addMeal,
            ),
            ListTile(
              leading: const Icon(Icons.local_hospital),
              title: const Text('Blood sugar'),
              onTap: _addBloodSugar,
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
