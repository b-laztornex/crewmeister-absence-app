import 'package:flutter/material.dart';

class FilterPanel extends StatefulWidget {
  const FilterPanel({super.key});

  @override
  _FilterPanelState createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  String? _selectedType;
  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _types = ['vacation', 'sickness'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Absences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Type'),
            value: _selectedType,
            items:
                _types
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                _selectedType = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  child: Text(
                    _startDate == null
                        ? 'Start Date'
                        : _startDate!.toLocal().toString().split(' ')[0],
                  ),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) setState(() => _startDate = date);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  child: Text(
                    _endDate == null
                        ? 'End Date'
                        : _endDate!.toLocal().toString().split(' ')[0],
                  ),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) setState(() => _endDate = date);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'type': null,
                    'startDate': null,
                    'endDate': null,
                  });
                },
                child: const Text('Clear'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'type': _selectedType,
                    'startDate': _startDate,
                    'endDate': _endDate,
                  });
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
