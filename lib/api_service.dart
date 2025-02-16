import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'http://<your_server_ip>:5000';

  // Fetch recycling summary
  Future<Map<String, int>?> getRecyclingSummary(String userId) async {
    try {
      var response = await http.get(
        Uri.parse('$apiUrl/summary/$userId'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return Map<String, int>.from(jsonDecode(response.body));
      } else {
        print('Failed to fetch summary: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching summary: $e');
      return null;
    }
  }

  // Fetch user achievements
  Future<List<String>?> getUserAchievements(String userId) async {
    try {
      var response = await http.get(
        Uri.parse('$apiUrl/achievements/$userId'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return List<String>.from(data['achievements']);
      } else {
        print('Failed to fetch achievements: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching achievements: $e');
      return null;
    }
  }
}
