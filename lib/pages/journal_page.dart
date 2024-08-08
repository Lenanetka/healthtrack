import 'package:flutter/material.dart';
import '../models/page_with_title.dart';
import '../pages/weight_page.dart';
import '../widgets/add_button.dart';
import '../widgets/journal_row.dart';
import '../models/journal_entry.dart';

class JournalPage extends StatefulWidget implements PageWithTitle {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
  @override
  String get title => 'Journal';
}

class _JournalPageState extends State<JournalPage> {
  List<JournalEntry> entries = [
    WeightEntry(dateTime: DateTime(2023, 8, 1, 10, 30), amount: 70.5),
    BloodSugarEntry(dateTime: DateTime(2023, 8, 1, 14, 10), amount: 120.0),
    WeightEntry(dateTime: DateTime(2023, 8, 1, 14, 15), amount: 70.2),
    WeightEntry(dateTime: DateTime(2023, 8, 2, 9, 45), amount: 70.0),
    WeightEntry(dateTime: DateTime(2023, 8, 2, 16, 30), amount: 70.1),
    WeightEntry(dateTime: DateTime(2023, 8, 3, 8, 0), amount: 69.8),
  ];

  String formatDate(DateTime dateTime) {
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final year = dateTime.year;
    return '$month/$day/$year';
  }

  Map<String, List<JournalEntry>> _groupedEntries() {
    final Map<String, List<JournalEntry>> groupedEntries = {};

    for (var entry in entries) {
      final String formattedDate = formatDate(entry.dateTime);
      if (!groupedEntries.containsKey(formattedDate)) {
        groupedEntries[formattedDate] = [];
      }
      groupedEntries[formattedDate]!.add(entry);
    }

    return groupedEntries;
  }

  void _editEntry(JournalEntry entry) {
    if (entry is WeightEntry) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const WeightPage(isEditMode: true)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedEntries = _groupedEntries();

    return Scaffold(
      body: ListView.builder(
        itemCount: groupedEntries.length,
        itemBuilder: (context, index) {
          final date = groupedEntries.keys.elementAt(index);
          final entries = groupedEntries[date]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ...entries.map((entry) {
                return JournalRow(
                  entry: entry,
                  onEdit: () => _editEntry(entry),
                );
              }),
              const Divider(),
            ],
          );
        },
      ),
      floatingActionButton: const AddButton(),
    );
  }
}
