import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/blood_sugar_page.dart';
import '../pages/meal_page.dart';
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
    Weight(dateTime: DateTime(2023, 8, 1, 10, 30), amount: 70.5, description: ''),
    Meal(dateTime: DateTime(2023, 8, 1, 12, 10), type: 'Breakfast', description: 'Bread and milk'),
    BloodSugar(dateTime: DateTime(2023, 8, 1, 14, 10), amount: 7.2, description: 'After food'),
    Weight(dateTime: DateTime(2023, 8, 1, 14, 15), amount: 70.2, description: 'Description'),
    Weight(dateTime: DateTime(2023, 8, 2, 9, 45), amount: 70.0, description: ''),
    Weight(dateTime: DateTime(2023, 8, 2, 16, 30), amount: 70.1, description: ''),
    Weight(dateTime: DateTime(2023, 8, 3, 8, 0), amount: 69.8, description: ''),
  ];

  String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('EEE, d MMM');
    return formatter.format(dateTime);
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

  void _openPage(page){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => page),
      );
  }

  void _editEntry(JournalEntry entry) {
    if(entry is Weight) _openPage(const WeightPage(isEditMode: true));
    if(entry is Meal) _openPage(const MealPage(isEditMode: true));
    if(entry is BloodSugar) _openPage(const BloodSugarPage(isEditMode: true));
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
