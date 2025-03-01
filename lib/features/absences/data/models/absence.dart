class Absence {
  final int id;
  final int userId;
  final int crewId;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final String? memberNote;
  final String? admitterNote;
  final DateTime? confirmedAt;
  final DateTime? rejectedAt;
  final DateTime createdAt;

  Absence({
    required this.id,
    required this.userId,
    required this.crewId,
    required this.type,
    required this.startDate,
    required this.endDate,
    this.memberNote,
    this.admitterNote,
    this.confirmedAt,
    this.rejectedAt,
    required this.createdAt,
  });

  factory Absence.fromJson(Map<String, dynamic> json) {
    return Absence(
      id: json['id'],
      userId: json['userId'],
      crewId: json['crewId'],
      type: json['type'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      memberNote:
          json['memberNote']?.isNotEmpty == true ? json['memberNote'] : null,
      admitterNote:
          json['admitterNote']?.isNotEmpty == true
              ? json['admitterNote']
              : null,
      confirmedAt:
          json['confirmedAt'] != null
              ? DateTime.parse(json['confirmedAt'])
              : null,
      rejectedAt:
          json['rejectedAt'] != null
              ? DateTime.parse(json['rejectedAt'])
              : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
