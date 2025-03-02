import 'package:equatable/equatable.dart';

class Member extends Equatable {
  final int id;
  final String name;
  final String image;

  Member({required this.id, required this.name, required this.image});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(id: json['id'], name: json['name'], image: json['image']);
  }

  @override
  List<Object?> get props => [id, name, image];
}
