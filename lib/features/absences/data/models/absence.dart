import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Absence extends Equatable {
  final int id;
  final int userId;
  String? memberName;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final String? memberNote;
  final String status;
  final String? admitterNote;

  Absence({
    required this.id,
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
    return Absence(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      memberNote:
          json['memberNote']?.toString().isNotEmpty == true
              ? json['memberNote']
              : null,
      status:
          json['confirmedAt'] != null
              ? 'Confirmed'
              : (json['rejectedAt'] != null ? 'Rejected' : 'Requested'),
      admitterNote:
          json['admitterNote']?.toString().isNotEmpty == true
              ? json['admitterNote']
              : null,
    );
  }

  String get startDateFormatted => DateFormat.yMMMd().format(startDate);
  String get endDateFormatted => DateFormat.yMMMd().format(endDate);

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
