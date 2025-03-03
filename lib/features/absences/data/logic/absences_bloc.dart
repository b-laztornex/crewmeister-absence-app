import 'package:cm_absence_manager/features/absences/data/models/absence.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'absences_event.dart';
import 'absences_state.dart';
import '../../data/repositories/absences_repository.dart';

/*
The class extends a Bloc which takes AbsencesEvent events and emits
AbsencesState states. It uses the repository to fetch absence data.
*/

class AbsencesBloc extends Bloc<AbsencesEvent, AbsencesState> {
  final AbsencesRepository repository;
  final int itemsPerPage = 10;

  String? _currentTypeFilter;
  DateTime? _currentStartDate;
  DateTime? _currentEndDate;
  int _currentPage = 1;

  AbsencesBloc(this.repository) : super(AbsencesLoading()) {
    on<LoadAbsences>(_onLoadAbsences);
    on<FilterAbsences>(_onFilterAbsences);
    on<ClearFilters>(_onClearFilters);
  }

  Future<void> _onLoadAbsences(
    LoadAbsences event,
    Emitter<AbsencesState> emit,
  ) async {
    emit(AbsencesLoading());
    try {
      _currentPage = event.page;
      _currentTypeFilter = event.typeFilter ?? _currentTypeFilter;
      _currentStartDate = event.startDate ?? _currentStartDate;
      _currentEndDate = event.endDate ?? _currentEndDate;
      final result = await repository.getAbsences(
        typeFilter: _currentTypeFilter,
        startDate: _currentStartDate,
        endDate: _currentEndDate,
        page: _currentPage,
        itemsPerPage: itemsPerPage,
      );

      final List<Absence> absences =
          (result['absences'] as List).cast<Absence>();

      final int totalAbsences = result['total'] as int;
      final int totalPages = result['totalPages'] as int;

      if (absences.isEmpty) {
        emit(AbsencesEmpty());
      } else {
        emit(
          AbsencesLoaded(
            absences: absences,
            currentPage: _currentPage,
            totalPages: totalPages,
            totalAbsences: totalAbsences,
            typeFilter: _currentTypeFilter,
            startDate: _currentStartDate,
            endDate: _currentEndDate,
          ),
        );
      }
    } catch (error) {
      emit(AbsencesError(message: error.toString()));
    }
  }

  Future<void> _onFilterAbsences(
    FilterAbsences event,
    Emitter<AbsencesState> emit,
  ) async {
    _currentTypeFilter = event.typeFilter;
    _currentStartDate = event.startDate;
    _currentEndDate = event.endDate;
    _currentPage = 1;
    add(
      LoadAbsences(
        page: _currentPage,
        typeFilter: _currentTypeFilter,
        startDate: _currentStartDate,
        endDate: _currentEndDate,
      ),
    );
  }

  Future<void> _onClearFilters(
    ClearFilters event,
    Emitter<AbsencesState> emit,
  ) async {
    _currentTypeFilter = null;
    _currentStartDate = null;
    _currentEndDate = null;
    _currentPage = 1;
    add(LoadAbsences(page: _currentPage));
  }
}
