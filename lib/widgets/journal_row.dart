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
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(entry.displayedContent),
              Text(formatTime(entry.datetime)),
            ],
          ),
          if (entry.description.isNotEmpty)
            Text(
              entry.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
      onTap: onEdit,
    );
  }
}
