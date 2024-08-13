import 'package:flutter/material.dart';
import '../models/journal_models.dart';

class JournalRow extends StatelessWidget {
  final Entry entry;
  final VoidCallback onEdit;

  const JournalRow({
    required this.entry,
    required this.onEdit,
    super.key,
  });

  String formatTime(DateTime dateTime) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: entry.icon,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(entry.displayedContent),
          Text(
            formatTime(entry.dateTime),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      subtitle: Text(entry.description),
      onTap: onEdit,
    );
  }
}