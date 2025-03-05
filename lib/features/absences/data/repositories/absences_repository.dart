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

  Future<Map<String, dynamic>> getAbsences({
    String? typeFilter,
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int itemsPerPage = 10,
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
            return (a.endDate ?? DateTime(1970, 1, 1)).compareTo(startDate) >=
                    0 &&
                (a.startDate ?? DateTime(1970, 1, 1)).compareTo(endDate) <= 0;
          }).toList();
    }

    final total = filtered.length;
    final totalPages = (total / itemsPerPage).ceil();
    final startIndex = (page - 1) * itemsPerPage;
    final paged = filtered.skip(startIndex).take(itemsPerPage).toList();

    return {'absences': paged, 'total': total, 'totalPages': totalPages};
  }
}
