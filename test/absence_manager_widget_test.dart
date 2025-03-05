import 'package:flutter_test/flutter_test.dart';
import 'package:cm_absence_manager/features/absences/data/models/absence.dart';
import 'package:cm_absence_manager/features/absences/data/models/member.dart';
import 'package:cm_absence_manager/features/absences/data/repositories/absences_repository.dart';
import 'package:cm_absence_manager/features/absences/data/services/absence_service.dart';

class FakeAbsenceService extends AbsenceService {
  @override
  Future<List<Absence>> fetchAbsences() async {
    return [
      Absence(
        id: 1,
        userId: 1,
        crewId: 352,
        type: 'vacation',
        startDate: DateTime(2021, 1, 1),
        endDate: DateTime(2021, 1, 2),
        memberName: null,
        memberNote: '',
        admitterNote: '',
        status: 'rejected',
      ),
    ];
  }

  @override
  Future<List<Member>> fetchMembers() async {
    return [Member(id: 1, userId: 1, crewId: 1, name: 'Alice', image: 'dummy')];
  }
}

class FakeAbsencesRepository extends AbsencesRepository {
  FakeAbsencesRepository() : super(FakeAbsenceService());

  @override
  Future<Map<String, dynamic>> getAbsences({
    String? typeFilter,
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int itemsPerPage = 10,
    String? statusFilter,
  }) async {
    return super.getAbsences(
      typeFilter: typeFilter,
      startDate: startDate,
      endDate: endDate,
      page: page,
      itemsPerPage: itemsPerPage,
    );
  }
}

void main() {
  group('FakeAbsencesRepository Tests', () {
    test(
      'Returns only vacation absences when type filter is applied',
      () async {
        final repository = FakeAbsencesRepository();
        final result = await repository.getAbsences(typeFilter: 'vacation');
        final absences = result['absences'] as List<Absence>;
        expect(absences.length, 1);
        expect(absences.first.type.toLowerCase(), equals('vacation'));
      },
    );

    test('Returns no absences when filtering for sickness', () async {
      final repository = FakeAbsencesRepository();
      final result = await repository.getAbsences(typeFilter: 'sickness');
      final absences = result['absences'] as List<Absence>;
      expect(absences.isEmpty, isTrue);
    });

    test(
      'Returns one absence when filtering by a date range that covers the absence',
      () async {
        final repository = FakeAbsencesRepository();
        final result = await repository.getAbsences(
          startDate: DateTime(2020, 12, 31),
          endDate: DateTime(2021, 1, 3),
        );
        final absences = result['absences'] as List<Absence>;
        expect(absences.length, 1);
        expect(absences.first.startDate, equals(DateTime(2021, 1, 1)));
      },
    );

    test(
      'Returns no absences when filtering by a date range that does not cover the absence',
      () async {
        final repository = FakeAbsencesRepository();
        final result = await repository.getAbsences(
          startDate: DateTime(2021, 1, 3),
          endDate: DateTime(2021, 1, 4),
        );
        final absences = result['absences'] as List<Absence>;
        expect(absences.isEmpty, isTrue);
      },
    );
  });
}
