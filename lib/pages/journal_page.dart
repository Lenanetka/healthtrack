import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  late JournalDatabase _db;
  List<Journal> _entries = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _db = Provider.of<JournalDatabase>(context, listen: false);
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    DateTime now = DateTime.now();
    DateTime oneMonthAgo = now.subtract(const Duration(days: 30));
    final fetchedEntries = await _db.getJournalByDate(oneMonthAgo, now);
    setState(() {
      _entries = fetchedEntries;
    });
  }

  Map<String, List<Journal>> _groupedEntries() {
    final Map<String, List<Journal>> groupedEntries = {};

    for (var entry in _entries) {
      final String formattedDate = formatDate(entry.dateTime);
      if (!groupedEntries.containsKey(formattedDate)) {
        groupedEntries[formattedDate] = [];
      }
      groupedEntries[formattedDate]!.add(entry);
    }

    return groupedEntries;
  }

  String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('EEE, d MMM');
    return formatter.format(dateTime);
  }

  Future<void> _openPage(page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<void> _addWeightEntry() async {
    await _openPage(WeightPage(
      isEditMode: false,
      entry: null,
      onSave: _loadEntries,
      onDelete: _loadEntries,
    ));
  }

  Future<void> _addMealEntry() async {
    await _openPage(MealPage(
      isEditMode: false,
      entry: null,
      onSave: _loadEntries,
      onDelete: _loadEntries,
    ));
  }

  Future<void> _addBloodSugarEntry() async {
    await _openPage(BloodSugarPage(
      isEditMode: false,
      entry: null,
      onSave: _loadEntries,
      onDelete: _loadEntries,
    ));
  }

  Future<void> _editEntry(Journal entry) async {
    if (entry is Weight) {
      await _openPage(WeightPage(
        isEditMode: true,
        entry: entry,
        onSave: _loadEntries,
        onDelete: _loadEntries,
      ));
    } else if (entry is Meal) {
      await _openPage(MealPage(
          isEditMode: true,
          entry: entry,
          onSave: _loadEntries,
          onDelete: _loadEntries));
    } else if (entry is BloodSugar) {
      await _openPage(BloodSugarPage(
          isEditMode: true,
          entry: entry,
          onSave: _loadEntries,
          onDelete: _loadEntries));
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
      body: groupedEntries.isEmpty
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
                        onEdit: () => _editEntry(entry),
                      );
                    }),
                    const Divider(),
                  ],
                );
              },
            ),
      floatingActionButton: AddButton(
        onAddWeight: _addWeightEntry,
        onAddMeal: _addMealEntry,
        onAddBloodSugar: _addBloodSugarEntry,
      ),
    );
  }
}
