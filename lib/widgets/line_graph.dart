import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../models/journal_models.dart';

class LineGraph extends StatelessWidget {
  final List<Entry> data;
  final bool showDifferenceBar;
  final bool showAverageBar;

  const LineGraph({
    super.key,
    required this.data,
    this.showDifferenceBar = false,
    this.showAverageBar = false,
  });

  String get type => data.first.type;
  double get minY => data.map((e) => double.parse(e.content)).reduce((a, b) => a < b ? a : b);
  double get maxY => data.map((e) => double.parse(e.content)).reduce((a, b) => a > b ? a : b);
  double get average => data.map((entry) => double.parse(entry.content)).reduce((a, b) => a + b) / data.length;

  String get minValue {
    if (data.isEmpty) return '-';
    final values = data.map((e) => double.parse(e.content)).toList();
    final result = values.reduce((a, b) => a < b ? a : b);
    return '$result ${Entry.units[type]}';
  }

  String get maxValue {
    if (data.isEmpty) return '-';
    final values = data.map((e) => double.parse(e.content)).toList();
    final result = values.reduce((a, b) => a > b ? a : b);
    return '$result ${Entry.units[type]}';
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const Row();

    final difference = double.parse(data.last.content) - double.parse(data.first.content);
    final double horizontalInterval = difference == 0 ? 1 : (difference.abs() / 2).ceilToDouble();

    Widget differenceBar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data.first.displayedContent,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Row(
            children: [
              Text(
                'Difference: ${difference.abs().toStringAsFixed(1)} ${Entry.units[type]}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(width: 4),
              Icon(
                difference > 0
                    ? Icons.arrow_upward
                    : difference < 0
                        ? Icons.arrow_downward
                        : Icons.horizontal_rule,
                color: difference > 0 ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ],
          ),
          Text(
            data.last.displayedContent,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      );
    }

    Widget averageBar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Min: $minValue',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Row(
            children: [
              Text(
                'Avg: ${average.toStringAsFixed(1)} ${Entry.units[type]}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Text(
            'Max: $maxValue',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDifferenceBar) differenceBar(),
        if (showAverageBar) averageBar(),
        const SizedBox(height: 16),
        // Graph
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: (data.length - 1).toDouble(),
              minY: minY - 1, // Adding some padding below the min value
              maxY: maxY + 1, // Adding some padding above the max value
              lineBarsData: [
                LineChartBarData(
                  spots: data.asMap().entries.where((entry) => entry.value.type == type).map((entry) {
                    final double weight = double.tryParse(entry.value.content) ?? 0.0;
                    final double x = entry.key.toDouble();
                    return FlSpot(x, weight);
                  }).toList(),
                  isCurved: true,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false, // Hide the left titles (Y-axis values)
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false, // Hide the bottom titles (X-axis dates)
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true, // Show grid lines
                drawVerticalLine: true,
                verticalInterval: 1,
                drawHorizontalLine: true,
                horizontalInterval: horizontalInterval,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.2),
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.2),
                  );
                },
              ),
              borderData: FlBorderData(
                show: true, // Show border lines around the chart
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  fitInsideHorizontally: true, // Keeps the tooltip inside horizontally
                  fitInsideVertically: true, // Keeps the tooltip inside vertically
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((touchedSpot) {
                      final index = touchedSpot.x.toInt();
                      final entry = data[index];
                      return LineTooltipItem(
                        '${entry.displayedContent}\n${DateFormat('d MMM, y').format(entry.datetime)}',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
                handleBuiltInTouches: true,
                getTouchedSpotIndicator: (barData, spotIndexes) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      FlLine(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        dashArray: [5, 5], // Create dashed effect
                      ),
                      const FlDotData(show: true),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
