import '../models/absence.dart';
import '../models/member.dart';
import '../services/absence_service.dart';

/* 
  This repository acts as an intermediary between the logic and the services 
  loading members, merging member name into each absence and apply filters if needed 
*/

class AbsencesRepository {
  final AbsenceService service;
  List<Member>? _cachedMembers;

  AbsencesRepository(this.service);

  Future<List<Absence>> getAbsences({
    String? typeFilter,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    //
    _cachedMembers ??= await service.fetchMembers();
    final absences = await service.fetchAbsences();

    //
    for (var absence in absences) {
      final member = _cachedMembers!.firstWhere(
        (m) => m.id == absence.userId,
        orElse: () => Member(id: absence.userId, name: 'Unknown', image: ''),
      );
      absence.memberName = member.name;
    }

    //
    List<Absence> filtered = absences;
    if (typeFilter != null && typeFilter.isNotEmpty) {
      filtered =
          filtered
              .where((a) => a.type.toLowerCase() == typeFilter.toLowerCase())
              .toList();
    }

    // Apply date filter if provided
    if (startDate != null && endDate != null) {
      filtered =
          filtered
              .where(
                (a) =>
                    !(a.endDate.isBefore(startDate) ||
                        a.startDate.isAfter(endDate)),
              )
              .toList();
    }
    return filtered;
  }
}
