import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/auth/logout_model.dart';
import '../../utils/api_url.dart';
import '../../utils/shared_preferences.dart';

class LogoutService {
  Future<LogoutResponse> logoutUser() async {
    final url = Uri.parse("${EnvConfig.baseUrl}/api/v1/logout-user");
    try {
      final accessToken = await ApplicationStorage.getAccessToken();
      final refreshToken = await ApplicationStorage.getRefreshToken();

      debugPrint("===== STORED TOKENS BEFORE LOGOUT =====");
      debugPrint("Access Token: $accessToken");
      debugPrint("Refresh Token: $refreshToken");
      debugPrint("======================================");

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
        await ApplicationStorage.removeTokens();

        debugPrint("===== LOGOUT SUCCESS =====");
        debugPrint("Tokens removed.");
        debugPrint("==========================");
      }
      return logoutResponse;
    } catch (e) {
      throw Exception("Failed to logout: $e");
    }
  }
}
