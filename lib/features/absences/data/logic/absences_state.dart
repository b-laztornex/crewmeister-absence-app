import 'package:equatable/equatable.dart';
import '../../data/models/absence.dart';

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

  const AbsencesLoaded({
    required this.absences,
    required this.currentPage,
    required this.totalPages,
    required this.totalAbsences,
  });

  @override
  List<Object?> get props => [absences, currentPage, totalPages, totalAbsences];
}

class AbsencesEmpty extends AbsencesState {}

class AbsencesError extends AbsencesState {
  final String message;
  const AbsencesError({required this.message});
  @override
  List<Object?> get props => [message];
}
