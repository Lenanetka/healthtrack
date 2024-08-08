import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime initialDateTime;
  final ValueChanged<DateTime> onDateTimeChanged;

  const DateTimePicker({
    required this.initialDateTime,
    required this.onDateTimeChanged,
    super.key,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
  }

  DateTime _selectedDate(){
    return DateTime(_selectedDateTime.year, _selectedDateTime.month, _selectedDateTime.day);
  }

  TimeOfDay _selectedTime(){
    return TimeOfDay(hour: _selectedDateTime.hour, minute: _selectedDateTime.minute);
  }

  DateTime combineDateTime(DateTime date, TimeOfDay time) {
      return DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
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
        _selectedDateTime = combineDateTime(pickedDate, _selectedTime());
      });
      widget.onDateTimeChanged(_selectedDateTime);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime(),
    );
    if (pickedTime != null && pickedTime != _selectedTime()) {
      setState(() {
        _selectedDateTime = combineDateTime(_selectedDate(), pickedTime);
      });
      widget.onDateTimeChanged(_selectedDateTime);
    }
  }

  // Format the date as MM/DD/YYYY
  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }

  // Format the time as HH:MM AM/PM
  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
  }

   @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Date Selector
        Expanded(
          child: InkWell(
            onTap: () => _selectDate(context),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
              ),
              child: Text(_formatDate(_selectedDate())),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        // Time Selector
        Expanded(
          child: InkWell(
            onTap: () => _selectTime(context),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Time',
                border: OutlineInputBorder(),
              ),
              child: Text(_formatTime(_selectedTime())),
            ),
          ),
        ),
      ],
    );
  }
}
