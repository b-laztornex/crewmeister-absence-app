import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/absences_repository.dart';
import '../../data/services/absence_service.dart';
import '../../data/logic/absences_bloc.dart';
import '../../data/logic/absences_event.dart';
import '../../data/logic/absences_state.dart';
import '../widgets/absence_list_item.dart';
import '../widgets/filter_panel.dart';
import '../widgets/pagination_controls.dart';

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
            IconButton(
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
                      startDate: filters['startDate'],
                      endDate: filters['endDate'],
                    ),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                _generateAndExportICal(context);
              },
            ),
          ],
        ),
        body: const AbsencesListBody(),
        bottomNavigationBar: const PaginationControls(),
      ),
    );
  }

  void _generateAndExportICal(BuildContext context) async {
    final repository = AbsencesRepository(AbsenceService());
    final absences = await repository.getAbsences();
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

class AbsencesListBody extends StatelessWidget {
  const AbsencesListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsencesBloc, AbsencesState>(
      builder: (context, state) {
        if (state is AbsencesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AbsencesError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is AbsencesEmpty) {
          return const Center(child: Text('No absences found.'));
        } else if (state is AbsencesLoaded) {
          return ListView.builder(
            itemCount: state.absences.length,
            itemBuilder: (context, index) {
              return AbsenceListItem(absence: state.absences[index]);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
