import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth/logout_model.dart';
import '../../utils/api_url.dart';

class LogoutService {
  Future<LogoutResponse> logoutUser() async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/logout-user");
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString("access_token");
      final refreshToken = prefs.getString("refresh_token");

      print("===== STORED TOKENS BEFORE LOGOUT =====");
      print("Access Token: $accessToken");
      print("Refresh Token: $refreshToken");
      print("======================================");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      final responseData = jsonDecode(response.body);
      final logoutResponse = LogoutResponse.fromJson(responseData);

      if (response.statusCode == 200) {
        await prefs.remove("access_token");
        await prefs.remove("refresh_token");

        print("===== LOGOUT SUCCESS =====");
        print("Tokens removed.");
        print("==========================");
      }
      return logoutResponse;
    } catch (e) {
      throw Exception("Failed to logout: $e");
    }
  }
}
