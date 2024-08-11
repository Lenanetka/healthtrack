import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/add_button.dart';
import '../widgets/journal_row.dart';

import '../models/page_with_title.dart';
import '../pages/blood_sugar_page.dart';
import '../pages/meal_page.dart';
import '../pages/weight_page.dart';

import '../models/journal.dart';
import '../models/journal_database.dart';

class JournalPage extends StatefulWidget implements PageWithTitle {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
  @override
  String get title => 'Journal';
}

class _JournalPageState extends State<JournalPage> {
  List<Journal> entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final db = JournalDatabase();
    DateTime now = DateTime.now();
    DateTime oneMonthAgo = now.subtract(const Duration(days: 30));
    final fetchedEntries = await db.getJournalByDate(now, oneMonthAgo);
    setState(() {
      entries = fetchedEntries;
    });
  }

  String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('EEE, d MMM');
    return formatter.format(dateTime);
  }

  Map<String, List<Journal>> _groupedEntries() {
    final Map<String, List<Journal>> groupedEntries = {};

    for (var entry in entries) {
      final String formattedDate = formatDate(entry.dateTime);
      if (!groupedEntries.containsKey(formattedDate)) {
        groupedEntries[formattedDate] = [];
      }
      groupedEntries[formattedDate]!.add(entry);
    }

    return groupedEntries;
  }

  Future<void> _openPage(page) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
    if (result == true) await _loadEntries();
  }

  Future<void> _editEntry(Journal entry) async {
    if (entry is Weight) {
      await _openPage(WeightPage(isEditMode: true, entry: entry));
    } else if (entry is Meal) {
      await _openPage(MealPage(isEditMode: true, entry: entry));
    } else if (entry is BloodSugar) {
      await _openPage(BloodSugarPage(isEditMode: true, entry: entry));
    }
  }

  Widget _notFoundPage() {
    return Center(
      child: Text(
        'No entries found. Please add some data.',
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupedEntries = _groupedEntries();

    return Scaffold(
      body: entries.isEmpty
          ? _notFoundPage()
          : ListView.builder(
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
                        onEdit: () => () async {
                          await _editEntry(entry);
                        },
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
