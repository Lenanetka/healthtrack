import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/page_with_title.dart';
import '../widgets/line_graph.dart';
import '../fields/period_selector.dart';

import '../models/journal_models.dart';
import '../models/journal_database.dart';

const Period defaultPeriod = Period.twoWeeks;

class BloodSugarStatisticsPage extends StatefulWidget implements PageWithTitle {
  const BloodSugarStatisticsPage({super.key});

  @override
  State<BloodSugarStatisticsPage> createState() => _BloodSugarStatisticsPageState();

  @override
  Icon get icon => const Icon(Icons.bar_chart);
  @override
  String get title => 'Statistics: Blood sugar';
}

class _BloodSugarStatisticsPageState extends State<BloodSugarStatisticsPage> {
  late JournalDatabase _db;
  DateTimeRange _selectedDateRange = periodDateRange(defaultPeriod);
  List<Entry> _data = [];

  @override
  void initState() {
    super.initState();
    _db = Provider.of<JournalDatabase>(context, listen: false);
    _data = [];
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final fetchedEntries = await _db.getJournalByRangeType(_selectedDateRange, Entry.bloodsugar);
    if (fetchedEntries.isNotEmpty) {
      setState(() {
        _data = fetchedEntries;
      });
    }
  }

  void _onPeriodRangeChanged(DateTimeRange range) {
    setState(() {
      _selectedDateRange = range;
      _loadEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: PeriodSelector(
        onPeriodRangeChanged: _onPeriodRangeChanged,
        defaultPeriod: defaultPeriod,
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineGraph(data: _data, showAverageBar: true),
      ),
    );
  }
}
