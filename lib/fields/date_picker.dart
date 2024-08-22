import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;

  const DatePicker({
    required this.onDateChanged,
    super.key,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = DateTime.now();
  }

  DateTime _selectedDate() {
    return DateTime(
        _selectedDateTime.year, _selectedDateTime.month, _selectedDateTime.day);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate()) {
      setState(() {
        _selectedDateTime = pickedDate;
      });
      widget.onDateChanged(_selectedDateTime);
    }
  }

  // Format the date as MM/DD/YYYY
  String _formatDate(DateTime date) {
    return 'Before: ${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 8.0),
              Text(
                _formatDate(_selectedDate()),
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
