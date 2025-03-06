import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/api_url.dart';

class LoginService {
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/login-user");
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
        headers: {
          "Content-Type": "application/json",
        },
      );
 
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to post API request");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
