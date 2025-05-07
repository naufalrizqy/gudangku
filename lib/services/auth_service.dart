import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://gudangku.my.id/api';

  static Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Login gagal - Status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Terjadi error saat login: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password, 
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print('Register gagal - Status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Terjadi error saat register: $e');
      return null;
    }
  }

}
