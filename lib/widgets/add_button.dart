import 'package:flutter/material.dart';
import '../pages/weight_page.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

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
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeightPage(isEditMode: false)),
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



