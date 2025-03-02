import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/absence.dart';
import '../models/member.dart';

class AbsenceService {
  Future<List<Absence>> fetchAbsences() async {
    await Future.delayed(Duration(seconds: 1)); // simulate network delay
    final jsonString = await rootBundle.loadString('assets/absences.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);
    final List<dynamic> payload = data['payload'];
    return payload.map((item) => Absence.fromJson(item)).toList();
  }

  Future<List<Member>> fetchMembers() async {
    final jsonString = await rootBundle.loadString('assets/members.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);
    final List<dynamic> payload = data['payload'];
    return payload.map((item) => Member.fromJson(item)).toList();
  }
}
