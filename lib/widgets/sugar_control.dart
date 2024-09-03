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

    double average = data.map((entry) => double.parse(entry.content)).reduce((a, b) => a + b) / data.length;
    double hba1cMPGM = (average + 2.59) / 1.59; //mmol/L
    double hba1cMPG = (average + 46.7) / 28.7; //mg/dL
    double hba1c = hba1cMPGM;

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

    Widget pieChart() {
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

    void showControlStatusInfo(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Control status'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Log at least 20 blood sugar values per week and don\'t skip more than 3 days, and even so it\'s far from being accurate.'),
                SizedBox(height: 16),
                Text('HbA1c <5% Dangerous'),
                SizedBox(height: 16),
                Text('HbA1c ≤ 5.6% Healthy'),
                SizedBox(height: 16),
                Text('HbA1c < 7% Good control'),
                SizedBox(height: 16),
                Text('HbA1c < 8% Moderate control'),
                SizedBox(height: 16),
                Text('HbA1c ≥ 8% Poor control'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }

    Widget sugarControl() {
      String controlStatus = 'Healthy';
      Color controlColor = Colors.green;
      if (hba1c < 5) {
        controlStatus = 'Dangerous';
        controlColor = Colors.red;
      }
      if (hba1c >= 5.7 && hba1c < 7) {
        controlStatus = 'Good control';
        controlColor = Colors.green;
      }
      if (hba1c >= 7 && hba1c < 8) {
        controlStatus = 'Moderate control';
        controlColor = Colors.orange;
      }
      if (hba1c >= 8) {
        controlStatus = 'Poor control';
        controlColor = Colors.red;
      }
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 16.0),
        child: Row(
          children: [
            Text(
              'HbA1c: ${hba1c.toStringAsFixed(2)}%',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16),
            Text(
              controlStatus,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: controlColor,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.help_outline, size: 20),
              onPressed: () => showControlStatusInfo(context),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [pieChart(), sugarControl()],
    );
  }
}
