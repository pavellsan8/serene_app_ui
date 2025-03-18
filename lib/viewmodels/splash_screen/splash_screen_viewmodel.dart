import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../utils/routes.dart';
import '../../services/auth/login_service.dart';

class SplashViewModel extends ChangeNotifier {
  final SharedPreferences prefs;
  final LoginService loginService;

  SplashViewModel(this.prefs, this.loginService);

  /// Mengecek apakah user sudah login
  Future<String> checkLoginStatus() async {
    final accessToken = prefs.getString("access_token");
    final refreshToken = prefs.getString("refresh_token");

    debugPrint("🔑 Access Token: $accessToken");

    // Cek jika kedua token tidak ada
    if ((accessToken == null || accessToken.isEmpty) &&
        (refreshToken == null || refreshToken.isEmpty)) {
      debugPrint("🚪 No token found, redirecting to Get Started...");
      return AppRoutes.getStarted;
    }

    // Cek apakah access token expired
    bool isTokenExpired =
        accessToken == null || JwtDecoder.isExpired(accessToken);

    if (!isTokenExpired) {
      return AppRoutes.getStarted; // ganti ke AppRoutes.home
    }
    debugPrint("🔄 Access token expired, checking refresh token...");

    bool isRefreshTokenExpired =
        refreshToken == null || JwtDecoder.isExpired(refreshToken);
    // Jika refresh token expired, langsung ke login
    if (!isRefreshTokenExpired) {
      debugPrint("⚠️ Refresh token expired, redirecting to Login...");
      return AppRoutes.login;
    }

    // Coba refresh token
    final newToken = await loginService.refreshToken();

    if (newToken != null) {
      debugPrint("✅ Token refreshed successfully, proceeding to Home...");
      return AppRoutes.getStarted; // ganti ke AppRoutes.home
    } else {
      debugPrint("❌ Failed to refresh token, redirecting to Login...");
      return AppRoutes.login;
    }
  }
}
