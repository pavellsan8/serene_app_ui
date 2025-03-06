import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/api_url.dart';

class ResetPasswordInputService {
  Future<Map<String, dynamic>> resetPassword(String email, String password) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/reset-password");
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
        throw Exception("Failed to reset password");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
