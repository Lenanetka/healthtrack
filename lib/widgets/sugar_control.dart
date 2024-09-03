import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/journal_models.dart';

const double low = 4;
const double high = 10;

class SugarControl extends StatelessWidget {
  final List<Entry> data;

  const SugarControl({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const Row();

    int lowTotal = data.where((entry) => double.parse(entry.content) <= low).length;
    int normalTotal =
        data.where((entry) => double.parse(entry.content) > low && double.parse(entry.content) < high).length;
    int highTotal = data.where((entry) => double.parse(entry.content) >= high).length;
    int total = lowTotal + normalTotal + highTotal;

    List<PieChartSectionData> sections = [];
    if (total > 0) {
      if (lowTotal > 0) {
        sections.add(PieChartSectionData(
          value: lowTotal / total,
          color: Colors.red,
          radius: 10,
          showTitle: false,
        ));
      }
      if (normalTotal > 0) {
        sections.add(PieChartSectionData(
          value: normalTotal / total,
          color: Colors.green,
          radius: 10,
          showTitle: false,
        ));
      }
      if (highTotal > 0) {
        sections.add(PieChartSectionData(
          value: highTotal / total,
          color: Colors.orange,
          radius: 10,
          showTitle: false,
        ));
      }
    }

    Widget legend(String label, Color color, int count, int total) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$label: ${(count / total * 100).toStringAsFixed(1)}% ($count)',
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 16),
        SizedBox(
          width: 90,
          height: 90,
          child: PieChart(
            PieChartData(
              sections: sections,
              sectionsSpace: 1,
              centerSpaceRadius: 30,
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              legend('Normal', Colors.green, normalTotal, total),
              legend('Hyperglycemia', Colors.orange, highTotal, total),
              legend('Hypoglycemia', Colors.red, lowTotal, total),
            ],
          ),
        ),
      ],
    );
  }
}
