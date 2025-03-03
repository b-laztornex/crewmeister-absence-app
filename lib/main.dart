import 'package:cm_absence_manager/features/absences/data/logic/absences_bloc.dart';
import 'package:cm_absence_manager/features/absences/data/logic/absences_event.dart';
import 'package:cm_absence_manager/features/absences/data/repositories/absences_repository.dart'
    show AbsencesRepository;
import 'package:cm_absence_manager/features/absences/data/services/absence_service.dart';
import 'package:cm_absence_manager/features/absences/presentation/pages/absences_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final repository = AbsencesRepository(AbsenceService());
  runApp(
    BlocProvider<AbsencesBloc>(
      create: (context) => AbsencesBloc(repository)..add(LoadAbsences()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absence Manager',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: AbsencesListPage(),
    );
  }
}
