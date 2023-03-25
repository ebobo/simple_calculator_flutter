import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5011';

  Future<bool> checkBackendHealth() async {
    final url = Uri.parse('$baseUrl/health');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
