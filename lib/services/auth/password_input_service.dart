import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/auth/forgot_password_model.dart';
import '../../utils/api_url.dart';

class ResetPasswordInputService {
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest request) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/reset-password");
    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);
      return ResetPasswordResponse.fromJson(responseData);
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
