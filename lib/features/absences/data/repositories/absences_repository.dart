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
    _cachedMembers ??= await service.fetchMembers();
    final absences = await service.fetchAbsences();

    for (var absence in absences) {
      final member = _cachedMembers!.firstWhere(
        (m) => m.userId == absence.userId,
        orElse:
            () => Member(
              id: absence.userId,
              userId: absence.userId,
              name: 'Unknown',
              image: '',
            ),
      );
      absence.memberName = member.name;
    }

    List<Absence> filtered = absences;

    if (typeFilter != null && typeFilter.isNotEmpty) {
      filtered =
          filtered.where((a) {
            return a.type.toLowerCase() == typeFilter.toLowerCase();
          }).toList();
    }

    if (startDate != null && endDate != null) {
      filtered =
          filtered.where((a) {
            return a.endDate.compareTo(startDate) >= 0 &&
                a.startDate.compareTo(endDate) <= 0;
          }).toList();
    }

    return filtered;
  }
}
