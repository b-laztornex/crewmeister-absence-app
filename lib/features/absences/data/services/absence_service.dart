import 'dart:convert';
import 'package:cm_absence_manager/config/api_config.dart';
import 'package:http/http.dart' as http;
import '../models/absence.dart';
import '../models/member.dart';

class AbsenceService {
  Future<List<Absence>> fetchAbsences() async {
    final url = '${ApiConfig.baseUrl}/absences';

    final response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> payload = data['payload'];
      return payload.map((item) => Absence.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load absences");
    }
  }

  Future<List<Member>> fetchMembers() async {
    final url = '${ApiConfig.baseUrl}/members';

    final response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> payload = data['payload'];
      return payload.map((item) => Member.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load members");
    }
  }
}
