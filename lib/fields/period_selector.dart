import 'package:flutter/material.dart';

enum Period {
  oneMonth,
  threeMonths,
  sixMonths,
  oneYear,
}

Map<String, Period> periodOptions = {
  '1 month': Period.oneMonth,
  '3 months': Period.threeMonths,
  '6 months': Period.sixMonths,
  '1 year': Period.oneYear,
};

class PeriodSelector extends StatefulWidget {
  final ValueChanged<DateTimeRange> onPeriodRangeChanged;

  const PeriodSelector({
    required this.onPeriodRangeChanged,
    super.key,
  });

  @override
  State<PeriodSelector> createState() => _PeriodSelectorState();
}

class _PeriodSelectorState extends State<PeriodSelector> {
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );
  Period? _selectedPeriod = Period.threeMonths;

  void _updateDateRange(DateTimeRange? newRange) {
    if (newRange != null && newRange != _selectedDateRange) {
      setState(() {
        _selectedDateRange = newRange;
      });
      widget.onPeriodRangeChanged(_selectedDateRange);
    }
  }

  void _resetPeriodSelection(DateTimeRange? newRange) {
    if (newRange != null && newRange != _selectedDateRange) {
      setState(() {
        _selectedPeriod = null;
      });
    }
  }

  Future<void> _dateRangePicker(BuildContext context) async {
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDateRange != null && pickedDateRange != _selectedDateRange) _selectedPeriod = null;
    _resetPeriodSelection(pickedDateRange);
    _updateDateRange(pickedDateRange);
  }

  void _onPeriodChanged(String period) {
    Period selectedPeriod = periodOptions[period]!;
    setState(() {
      _selectedPeriod = selectedPeriod;
      _updateDateRange(_periodDateRange(selectedPeriod));
    });
  }

  DateTimeRange _periodDateRange(Period period) {
    final now = DateTime.now();
    DateTimeRange range;

    switch (period) {
      case Period.oneMonth:
        range = DateTimeRange(
          start: now.subtract(const Duration(days: 30)),
          end: now,
        );
        break;
      case Period.threeMonths:
        range = DateTimeRange(
          start: now.subtract(const Duration(days: 90)),
          end: now,
        );
        break;
      case Period.sixMonths:
        range = DateTimeRange(
          start: now.subtract(const Duration(days: 180)),
          end: now,
        );
        break;
      case Period.oneYear:
        range = DateTimeRange(
          start: now.subtract(const Duration(days: 365)),
          end: now,
        );
        break;
      default:
        range = _selectedDateRange;
        break;
    }
    return range;
  }

  String _formatDateRange(DateTimeRange dateRange) {
    final start =
        '${dateRange.start.month.toString().padLeft(2, '0')}/${dateRange.start.day.toString().padLeft(2, '0')}/${dateRange.start.year}';
    final end =
        '${dateRange.end.month.toString().padLeft(2, '0')}/${dateRange.end.day.toString().padLeft(2, '0')}/${dateRange.end.year}';
    return '$start - $end';
  }

  @override
  Widget build(BuildContext context) {
    List<String> displayedPeriodOptions = periodOptions.keys.toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Period Selection Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: displayedPeriodOptions.map((option) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: TextButton(
                  onPressed: () => _onPeriodChanged(option),
                  style: TextButton.styleFrom(
                    foregroundColor: _selectedPeriod == periodOptions[option]!
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).textTheme.bodyMedium?.color,
                    backgroundColor: _selectedPeriod == periodOptions[option]!
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                        : Colors.transparent,
                    side: BorderSide(
                      color: _selectedPeriod == periodOptions[option]!
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).dividerColor,
                      width: 1.0,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  ),
                  child: Text(option),
                ),
              );
            }).toList(),
          ),
          const SizedBox(width: 8),
          // Period Picker
          InkWell(
            onTap: () => _dateRangePicker(context),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 8.0),
                    Text(
                      _formatDateRange(_selectedDateRange),
                      style: const TextStyle(fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
