import 'package:flutter/material.dart';
import '../../data/models/absence.dart';

class AbsenceListItem extends StatelessWidget {
  final Absence absence;
  const AbsenceListItem({super.key, required this.absence});

  @override
  Widget build(BuildContext context) {
    // Pick a background color based on the status
    Color chipColor;
    switch (absence.status.toLowerCase()) {
      case 'confirmed':
        chipColor = Colors.green;
        break;
      case 'rejected':
        chipColor = Colors.red;
        break;
      default: // 'requested' or any other
        chipColor = Colors.blue;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text('${absence.memberName} - ${absence.type}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Period: ${absence.startDateFormatted} to ${absence.endDateFormatted}',
            ),
            if (absence.memberNote != null) Text('Note: ${absence.memberNote}'),
            if (absence.admitterNote != null)
              Text('Admitter: ${absence.admitterNote}'),
          ],
        ),
        trailing: Chip(
          label: Text(
            absence.status,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: chipColor,
        ),
      ),
    );
  }
}
