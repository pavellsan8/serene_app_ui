import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/auth/login_model.dart';
import '../../utils/api_url.dart';
import '../../utils/shared_preferences.dart';

class LoginService {
  Future<LoginResponse> loginUser(LoginRequest request) async {
    // Login url endpoint
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/login-user");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        // Login body param input
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);

      // Login response body output
      final loginResponse = LoginResponse.fromJson(responseData);
      if (loginResponse.data != null) {
        // simpan data email, access token dan refresh token
        await ApplicationStorage.saveEmail(request.email);
        await ApplicationStorage.saveAccessToken(
            loginResponse.data!.accessToken);
        await ApplicationStorage.saveRefreshToken(
            loginResponse.data!.refreshToken);
      }

      return loginResponse;
    } catch (e) {
      throw Exception("Failed to register: $e");
    }
  }

  Future<String?> refreshToken() async {
    final refreshToken = await ApplicationStorage.getRefreshToken();

    if (refreshToken == null) {
      return null;
    }

    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/refresh-token");

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $refreshToken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final newAccessToken = responseData["data"]["access_token"];

        ApplicationStorage.saveAccessToken(newAccessToken);
        return newAccessToken;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
