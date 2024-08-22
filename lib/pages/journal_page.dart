import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/add_button.dart';
import '../widgets/journal_row.dart';

import '../models/page_with_title.dart';
import 'entries/add_entry_page.dart';
import 'entries/edit_entry_page.dart';

import '../models/journal_models.dart';
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
  final List<Entry> _entries = [];
  final _scrollController = ScrollController();
  DateTime _fromDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _db = Provider.of<JournalDatabase>(context, listen: false);
    _scrollController.addListener(_loadMore);
    _loadEntries();
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadEntries();
    }
  }

  Future<void> _loadEntries() async {
    final fetchedEntries =
        await _db.getJournalByDate(_fromDateTime);

    if (fetchedEntries.isNotEmpty) {
      setState(() {
        _entries.addAll(fetchedEntries);
        _fromDateTime = fetchedEntries.last.datetime;
      });
    }
  }

  Map<String, List<Entry>> _groupedEntries() {
    final Map<String, List<Entry>> groupedEntries = {};

    for (var entry in _entries) {
      final String formattedDate =
          DateFormat('EEE, d MMM').format(entry.datetime);
      if (!groupedEntries.containsKey(formattedDate)) {
        groupedEntries[formattedDate] = [];
      }
      groupedEntries[formattedDate]!.add(entry);
    }

    return groupedEntries;
  }

  Future<void> _addEntry(Entry entryToAdd) async {
    int index = _entries
        .indexWhere((entry) => entry.datetime.isBefore(entryToAdd.datetime));
    if (index != -1) {
      setState(() {
         _entries.insert(index, entryToAdd);
      });
    }
  }

  Future<void> _updateEntry(Entry entryToUpdate) async {
    final index = _entries.indexWhere((entry) => entry.id == entryToUpdate.id);
    if (index != -1) {
      setState(() {
        _entries[index] = entryToUpdate;
      });
    }
  }

  Future<void> _removeEntry(Entry entryToDelete) async {
    setState(() {
      _entries.removeWhere((entry) => entry.id == entryToDelete.id);
    });
  }

  Future<void> _openPage(page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<void> _addPage(String type) async {
    await _openPage(AddEntryPage(
      type: type,
      onAdded: (entry) => _addEntry(entry),
    ));
  }

  Future<void> _editPage(Entry entry) async {
    await _openPage(EditEntryPage(
      entry: entry,
      onEdited: (entry) => _updateEntry(entry),
      onDeleted: (entry) => _removeEntry(entry),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final groupedEntries = _groupedEntries();

    Widget emptyList() {
      return Center(
        child: Text(
          'No entries found. Please add some data.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      );
    }

    Widget journalList() {
      return ListView.builder(
        controller: _scrollController,
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
                  onEdit: () => _editPage(entry),
                );
              }),
              const Divider(),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: groupedEntries.isEmpty ? emptyList() : journalList(),
      floatingActionButton: AddButton(
        onAdd: (String type) => _addPage(type),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
