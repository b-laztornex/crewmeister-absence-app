import 'package:equatable/equatable.dart';

/*
Fetches absence data from the repository,
FilterAbsences and Resets all filter values
*/

abstract class AbsencesEvent extends Equatable {
  const AbsencesEvent();
  @override
  List<Object?> get props => [];
}

class LoadAbsences extends AbsencesEvent {
  final int page;
  final String? typeFilter;
  final String? statusFilter;
  final DateTime? startDate;
  final DateTime? endDate;

  const LoadAbsences({
    this.page = 1,
    this.typeFilter,
    this.statusFilter,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [
    page,
    typeFilter,
    statusFilter,
    startDate,
    endDate,
  ];
}

class FilterAbsences extends AbsencesEvent {
  final String? typeFilter;
  final String? statusFilter;
  final DateTime? startDate;
  final DateTime? endDate;

  const FilterAbsences({
    this.typeFilter,
    this.statusFilter,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [typeFilter, statusFilter, startDate, endDate];
}

class ClearFilters extends AbsencesEvent {}
