import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/auth/forgot_password_model.dart';
import '../../utils/api_url.dart';

class EmailOtpInputService {
  Future<EmailOtpResponse> sendOtp(EmailOtpRequest request) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/email-otp-verification");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);
      return EmailOtpResponse.fromJson(responseData);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
