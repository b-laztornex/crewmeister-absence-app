import 'package:cm_absence_manager/features/absences/data/logic/absences_bloc.dart';
import 'package:cm_absence_manager/features/absences/data/logic/absences_state.dart';
import 'package:cm_absence_manager/features/absences/presentation/widgets/absence_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
