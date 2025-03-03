import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/logic/absences_bloc.dart';
import '../../data/logic/absences_state.dart';
import '../../data/logic/absences_event.dart';

class FilterTags extends StatelessWidget {
  const FilterTags({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsencesBloc, AbsencesState>(
      builder: (context, state) {
        String? type;
        DateTime? start;
        DateTime? end;

        if (state is AbsencesLoaded) {
          type = state.typeFilter;
          start = state.startDate;
          end = state.endDate;
        }
        if (type == null && start == null && end == null) {
          return const SizedBox.shrink();
        }

        List<Widget> tags = [];
        if (type != null && type.isNotEmpty) {
          tags.add(_buildTag(context, 'Type: $type'));
        }
        if (start != null && end != null) {
          final dateTag =
              'Dates: ${start.toLocal().toString().split(' ')[0]} to ${end.toLocal().toString().split(' ')[0]}';
          tags.add(_buildTag(context, dateTag));
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(spacing: 8.0, children: tags),
        );
      },
    );
  }

  Widget _buildTag(BuildContext context, String label) {
    return Chip(
      label: Text(label),
      deleteIcon: const Icon(Icons.close),
      onDeleted: () {
        context.read<AbsencesBloc>().add(ClearFilters());
      },
    );
  }
}
