import 'package:equatable/equatable.dart';
import '../../data/models/absence.dart';

/*
holds variables to keep track of filters (absence type, start and end dates) and the current page for pagination.
*/

abstract class AbsencesState extends Equatable {
  const AbsencesState();
  @override
  List<Object?> get props => [];
}

class AbsencesLoading extends AbsencesState {}

class AbsencesLoaded extends AbsencesState {
  final List<Absence> absences;
  final int currentPage;
  final int totalPages;
  final int totalAbsences;
  final String? typeFilter;
  final String? statusFilter;

  final DateTime? startDate;
  final DateTime? endDate;

  const AbsencesLoaded({
    required this.absences,
    required this.currentPage,
    required this.totalPages,
    required this.totalAbsences,
    this.typeFilter,
    this.statusFilter,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [
    absences,
    currentPage,
    totalPages,
    totalAbsences,
    typeFilter,
    statusFilter,
    startDate,
    endDate,
  ];
}

class AbsencesEmpty extends AbsencesState {}

class AbsencesError extends AbsencesState {
  final String message;
  const AbsencesError({required this.message});
  @override
  List<Object?> get props => [message];
}
