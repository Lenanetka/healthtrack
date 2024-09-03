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
              Expanded(
                child: Text(
                  entry.displayedContent,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Text(
                formatTime(entry.datetime),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          if (entry.description.isNotEmpty)
            Text(
              entry.description,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
        ],
      ),
      onTap: onEdit,
    );
  }
}
