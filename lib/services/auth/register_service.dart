import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/auth/register_model.dart';
import '../../utils/api_url.dart';

class RegisterService {
  Future<RegisterResponse> registerUser(RegisterRequest request) async {
    // register url API
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/register-user");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        // request parameters data
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);
      return RegisterResponse.fromJson(responseData);
    } catch (e) {
      throw Exception("Failed to register: $e");
    }
  }
}
