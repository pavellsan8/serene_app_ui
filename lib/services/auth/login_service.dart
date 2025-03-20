import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth/login_model.dart';
import '../../utils/api_url.dart';

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
        final prefs = await SharedPreferences.getInstance();

        // simpan data email, access token dan refresh token
        await prefs.setString("email", request.email);
        await prefs.setString(
            "access_token", loginResponse.data?.accessToken ?? "");
        await prefs.setString(
            "refresh_token", loginResponse.data?.refreshToken ?? "");

        debugPrint('===== SAVED TOKEN DATA =====');
        debugPrint('access_token: ${prefs.getString("access_token")}');
        debugPrint('refresh_token: ${prefs.getString("refresh_token")}');
        debugPrint('============================');
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
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "refresh_token": refreshToken,
        }),
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
