import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/logic/absences_bloc.dart';
import '../../data/logic/absences_event.dart';
import '../../data/logic/absences_state.dart';

class PaginationControls extends StatelessWidget {
  const PaginationControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsencesBloc, AbsencesState>(
      builder: (context, state) {
        if (state is AbsencesLoaded) {
          return BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: ${state.totalAbsences}'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed:
                            state.currentPage > 1
                                ? () {
                                  context.read<AbsencesBloc>().add(
                                    LoadAbsences(page: state.currentPage - 1),
                                  );
                                }
                                : null,
                      ),
                      Text('${state.currentPage} / ${state.totalPages}'),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed:
                            state.currentPage < state.totalPages
                                ? () {
                                  context.read<AbsencesBloc>().add(
                                    LoadAbsences(page: state.currentPage + 1),
                                  );
                                }
                                : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox(height: 56); // default bottom space
      },
    );
  }
}
