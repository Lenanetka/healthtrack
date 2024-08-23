import 'package:flutter/material.dart';
import '../models/journal_models.dart';

class FilterJournal extends StatefulWidget {
  final ValueChanged<String> onFilterChanged;

  const FilterJournal({
    required this.onFilterChanged,
    super.key,
  });

  @override
  State<FilterJournal> createState() => _FilterJournalState();
}

class _FilterJournalState extends State<FilterJournal> {
  late String _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = Entry.all;
  }

  void _onFilterSelected(String filter) {
    if (filter != _selectedFilter) {
      setState(() => _selectedFilter = filter);
      widget.onFilterChanged(_selectedFilter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: _onFilterSelected,
      initialValue: _selectedFilter,
      itemBuilder: (context) {
        return Entry.names.map((entry) {
          return PopupMenuItem<String>(
            value: Entry.optionByName[entry],
            child: Row(
              children: [
                Entry.icons[Entry.optionByName[entry]]!,
                const SizedBox(width: 8.0),
                Text(entry),
              ],
            ),
          );
        }).toList();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Entry.icons[_selectedFilter]!,
            const SizedBox(width: 8.0),
            const Text('Filter', style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
