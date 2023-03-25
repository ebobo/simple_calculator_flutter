import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String plusServiceUrl = 'http://localhost:5011';

  Future<bool> checkPlusServiceHealth() async {
    final url = Uri.parse('$plusServiceUrl/health');
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

  Future<double> plus(double a, double b) async {
    final url = Uri.parse('$plusServiceUrl/add');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, double>{
          'a': a,
          'b': b,
        }),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['result'];
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }
}
