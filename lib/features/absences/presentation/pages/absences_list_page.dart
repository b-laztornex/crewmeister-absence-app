import 'package:cm_absence_manager/features/absences/presentation/widgets/absences_list_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/absences_repository.dart';
import '../../data/services/absence_service.dart';
import '../../data/logic/absences_bloc.dart';
import '../../data/logic/absences_event.dart';
import '../widgets/filter_panel.dart';
import '../widgets/pagination_controls.dart';
import '../widgets/filter_tags.dart';

class AbsencesListPage extends StatelessWidget {
  const AbsencesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = AbsencesRepository(AbsenceService());
    return BlocProvider(
      create: (_) => AbsencesBloc(repository)..add(const LoadAbsences()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Absence Manager'),
          actions: [
            Builder(
              builder:
                  (context) => IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () async {
                      final filters =
                          await showModalBottomSheet<Map<String, dynamic>>(
                            context: context,
                            builder: (_) => const FilterPanel(),
                          );
                      if (filters != null) {
                        context.read<AbsencesBloc>().add(
                          FilterAbsences(
                            typeFilter: filters['type'],
                            statusFilter: filters['status'],
                            startDate: filters['startDate'],
                            endDate: filters['endDate'],
                          ),
                        );
                      }
                    },
                  ),
            ),
            Builder(
              builder:
                  (context) => IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      _generateAndExportICal(context);
                    },
                  ),
            ),
          ],
        ),
        body: Column(
          children: const [
            FilterTags(), // Displays active filters as tags.
            Expanded(child: AbsencesListBody()),
          ],
        ),
        bottomNavigationBar: const PaginationControls(),
      ),
    );
  }

  void _generateAndExportICal(BuildContext context) async {
    final repository = AbsencesRepository(AbsenceService());
    final result = await repository.getAbsences();
    final absences = result['absences'] as List;
    final icsContent = generateICS(absences);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('iCal file generated (${icsContent.length} characters)'),
      ),
    );
  }

  String generateICS(List absences) {
    final buffer = StringBuffer();
    buffer.writeln('BEGIN:VCALENDAR');
    buffer.writeln('VERSION:2.0');
    buffer.writeln('PRODID:-//Crewmeister Absence Manager//EN');
    for (var absence in absences) {
      buffer.writeln('BEGIN:VEVENT');
      buffer.writeln('UID:${absence.id}@crewmeister.com');
      buffer.writeln('SUMMARY:${absence.memberName} - ${absence.type}');
      buffer.writeln(
        'DESCRIPTION:Status: ${absence.status}\\nMember Note: ${absence.memberNote ?? ""}\\nAdmitter Note: ${absence.admitterNote ?? ""}',
      );
      buffer.writeln('DTSTART:${_formatDateToICS(absence.startDate)}');
      buffer.writeln(
        'DTEND:${_formatDateToICS(absence.endDate.add(const Duration(days: 1)))}',
      );
      buffer.writeln('END:VEVENT');
    }
    buffer.writeln('END:VCALENDAR');
    return buffer.toString();
  }

  String _formatDateToICS(DateTime date) {
    return '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
  }
}
