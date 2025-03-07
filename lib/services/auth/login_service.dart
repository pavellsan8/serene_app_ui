import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth/login_model.dart';
import '../../utils/api_url.dart';

class LoginService {
  Future<LoginResponse> loginUser(LoginRequest request) async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/login-user");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);
      final loginResponse = LoginResponse.fromJson(responseData);

      if (loginResponse.data != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("email", request.email);
        await prefs.setString("access_token", loginResponse.data!.accessToken);
        await prefs.setString(
            "refresh_token", loginResponse.data!.refreshToken);

        print('===== SAVED TOKEN DATA =====');
        print('access_token: ${prefs.getString("access_token")}');
        print('refresh_token: ${prefs.getString("refresh_token")}');
        print('============================');
      }

      return loginResponse;
    } catch (e) {
      throw Exception("Failed to register: $e");
    }
  }

  Future<String?> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString("refresh_token");

    if (refreshToken == null) {
      return null;
    }

    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/refresh-token");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"refresh_token": refreshToken}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final newAccessToken = responseData["access_token"];

        await prefs.setString("access_token", newAccessToken);
        return newAccessToken;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
