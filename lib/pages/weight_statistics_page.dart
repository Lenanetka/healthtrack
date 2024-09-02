import 'package:flutter/material.dart';

import '../models/page_with_title.dart';
import '../widgets/weight_graph.dart';
import '../fields/period_selector.dart';

import '../models/journal_models.dart';
import '../models/journal_database.dart';

class WeightStatisticsPage extends StatefulWidget implements PageWithTitle {
  const WeightStatisticsPage({super.key});

  @override
  State<WeightStatisticsPage> createState() => _WeightStatisticsPageState();

  @override
  String get title => 'Statistics: Weight';
}

class _WeightStatisticsPageState extends State<WeightStatisticsPage> {
  final List<Entry> weightData = [
    // Mock data for demonstration
    Weight(datetime: DateTime.now().subtract(const Duration(days: 90)), amount: 70, description: ''),
    Weight(datetime: DateTime.now().subtract(const Duration(days: 75)), amount: 69, description: ''),
    Weight(datetime: DateTime.now().subtract(const Duration(days: 60)), amount: 68, description: ''),
    Weight(datetime: DateTime.now().subtract(const Duration(days: 45)), amount: 69.5, description: ''),
    Weight(datetime: DateTime.now().subtract(const Duration(days: 30)), amount: 67, description: ''),
    Weight(datetime: DateTime.now().subtract(const Duration(days: 15)), amount: 66.5, description: ''),
    Weight(datetime: DateTime.now(), amount: 67.5, description: ''),
  ];

  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  void _onPeriodRangeChanged(DateTimeRange range) {
    setState(() {
      _selectedDateRange = range;
      // Update the weightData based on the selected date range
      // Implement this logic as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: PeriodSelector(onPeriodRangeChanged: _onPeriodRangeChanged)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: WeightGraph(data: weightData),
      ),
    );
  }
}
