import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/api_url.dart';

class EmailOtpInputService {
  Future<Map<String, dynamic>> sendOtp(String email) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/email-otp-verification");
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
          },
        ),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to send OTP");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
