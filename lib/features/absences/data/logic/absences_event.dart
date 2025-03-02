import 'package:equatable/equatable.dart';

abstract class AbsencesEvent extends Equatable {
  const AbsencesEvent();
  @override
  List<Object?> get props => [];
}

class LoadAbsences extends AbsencesEvent {
  final int page;
  final String? typeFilter;
  final DateTime? startDate;
  final DateTime? endDate;

  const LoadAbsences({
    this.page = 1,
    this.typeFilter,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [page, typeFilter, startDate, endDate];
}

class FilterAbsences extends AbsencesEvent {
  final String? typeFilter;
  final DateTime? startDate;
  final DateTime? endDate;

  const FilterAbsences({this.typeFilter, this.startDate, this.endDate});

  @override
  List<Object?> get props => [typeFilter, startDate, endDate];
}
