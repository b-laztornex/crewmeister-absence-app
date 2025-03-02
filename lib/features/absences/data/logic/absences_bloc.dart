import 'package:flutter_bloc/flutter_bloc.dart';
import 'absences_event.dart';
import 'absences_state.dart';
import '../../data/repositories/absences_repository.dart';

class AbsencesBloc extends Bloc<AbsencesEvent, AbsencesState> {
  final AbsencesRepository repository;
  final int itemsPerPage = 10;

  AbsencesBloc(this.repository) : super(AbsencesLoading()) {
    on<LoadAbsences>(_onLoadAbsences);
    on<FilterAbsences>(_onFilterAbsences);
  }

  Future<void> _onLoadAbsences(
    LoadAbsences event,
    Emitter<AbsencesState> emit,
  ) async {
    emit(AbsencesLoading());
    try {
      final allAbsences = await repository.getAbsences(
        typeFilter: event.typeFilter,
        startDate: event.startDate,
        endDate: event.endDate,
      );

      final totalAbsences = allAbsences.length;
      final totalPages = (totalAbsences / itemsPerPage).ceil();
      final startIndex = (event.page - 1) * itemsPerPage;
      final pagedAbsences =
          allAbsences.skip(startIndex).take(itemsPerPage).toList();

      if (pagedAbsences.isEmpty) {
        emit(AbsencesEmpty());
      } else {
        emit(
          AbsencesLoaded(
            absences: pagedAbsences,
            currentPage: event.page,
            totalPages: totalPages,
            totalAbsences: totalAbsences,
          ),
        );
      }
    } catch (e) {
      emit(AbsencesError(message: e.toString()));
    }
  }

  Future<void> _onFilterAbsences(
    FilterAbsences event,
    Emitter<AbsencesState> emit,
  ) async {
    add(
      LoadAbsences(
        page: 1,
        typeFilter: event.typeFilter,
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );
  }
}
