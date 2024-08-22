import 'package:flutter/material.dart';

class FilterJournal extends StatefulWidget {
  final ValueChanged<String> onFilterChanged;

  const FilterJournal({
    required this.onFilterChanged,
    super.key,
  });

  @override
  State<FilterJournal> createState() => _FilterJournalState();
}

class _FilterJournalState extends State<FilterJournal> {
  late String _selectedFilter;
  //all, weight, bloodsugar or meal can be selected

  @override
  void initState() {
    super.initState();
    _selectedFilter = 'mocked';
  }

  Future<void> _filter(BuildContext context) async {
    //ADD Select in popup
    final String? pickedFilter = 'mocked';
    if (pickedFilter != null && pickedFilter != _selectedFilter) {
      setState(() {
        _selectedFilter = pickedFilter;
      });
      widget.onFilterChanged(_selectedFilter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _filter(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.filter_list),
              SizedBox(width: 8.0),
              Text(
                'Filter',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
