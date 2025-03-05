import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Absence extends Equatable {
  final int id;
  final int crewId;
  final int userId;
  String? memberName;
  final String type;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? memberNote;
  final String status;
  final String? admitterNote;

  Absence({
    required this.id,
    required this.crewId,
    required this.userId,
    this.memberName,
    required this.type,
    required this.startDate,
    required this.endDate,
    this.memberNote,
    required this.status,
    this.admitterNote,
  });

  factory Absence.fromJson(Map<String, dynamic> json) {
    final confirmedAt = json['confirmedat']?.toString();
    final rejectedAt = json['rejectedat']?.toString();

    final status =
        (confirmedAt != null && confirmedAt.isNotEmpty)
            ? 'Confirmed'
            : (rejectedAt != null && rejectedAt.isNotEmpty)
            ? 'Rejected'
            : 'Requested';

    final rawStart = json['startdate']?.toString();
    final rawEnd = json['enddate']?.toString();

    return Absence(
      id: json['id'] ?? 0,
      userId: json['userid'] ?? 0,
      crewId: json['crewid'] ?? 0,
      type: json['type'] ?? 'Unknown',
      startDate: (rawStart != null) ? DateTime.tryParse(rawStart) : null,
      endDate: (rawEnd != null) ? DateTime.tryParse(rawEnd) : null,
      memberNote:
          (json['membernote']?.toString().isNotEmpty == true)
              ? json['membernote']
              : null,
      status: status,
      admitterNote:
          (json['admitternote']?.toString().isNotEmpty == true)
              ? json['admitternote']
              : null,
      memberName: null,
    );
  }

  String get startDateFormatted =>
      DateFormat.yMMMd().format(startDate ?? DateTime(1970, 1, 1));

  String get endDateFormatted =>
      DateFormat.yMMMd().format(endDate ?? DateTime(1970, 1, 1));

  @override
  List<Object?> get props => [
    id,
    userId,
    type,
    startDate,
    endDate,
    memberNote,
    status,
    admitterNote,
  ];
}
