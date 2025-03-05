import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/absence.dart';
import '../data/models/member.dart';
import '../../../config/api_config.dart';

class AbsenceService {
  Future<List<Absence>> fetchAbsences() async {
    final url = '${ApiConfig.baseUrl}/absences';
    final response = await http.get(Uri.parse(url));

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
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> payload = data['payload'];
      return payload.map((item) => Member.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load members");
    }
  }
}
