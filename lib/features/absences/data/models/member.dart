import 'package:equatable/equatable.dart';

class Member extends Equatable {
  final int id;
  final int userId;
  final int crewId;
  final String name;
  final String image;

  const Member({
    required this.id,
    required this.userId,
    required this.crewId,
    required this.name,
    required this.image,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      userId: json['userid'],
      crewId: json['crewid'],
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, userId, crewId, name, image];
}
