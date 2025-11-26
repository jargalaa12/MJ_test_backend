import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api'; // Android emulator

  Future<List<dynamic>> getQuestions() async {
    final res = await http.get(Uri.parse('$baseUrl/questions/'));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
