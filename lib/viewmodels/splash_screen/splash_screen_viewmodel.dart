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
    debugPrint("🔑 Refresh Token: $refreshToken");

    // Jika kedua token tidak ada, arahkan ke Get Started
    if ((accessToken == null || accessToken.isEmpty) &&
        (refreshToken == null || refreshToken.isEmpty)) {
      debugPrint("🚪 No token found, redirecting to Get Started...");
      return AppRoutes.getStarted;
    }

    bool isRefreshTokenExpired =
        refreshToken == null || JwtDecoder.isExpired(refreshToken);

    // Jika refresh token expired, langsung ke login
    if (isRefreshTokenExpired) {
      debugPrint("⚠️ Refresh token expired, redirecting to Login...");
      return AppRoutes.login;
    }

    // Cek apakah access token expired
    bool isAccessTokenExpired =
        accessToken == null || JwtDecoder.isExpired(accessToken);

    if (!isAccessTokenExpired) {
      debugPrint("✅ Access token valid, redirecting to Home...");
      return AppRoutes.homePage;
    } else {
      debugPrint("🔄 Access token expired, attempting refresh...");
      final newToken = await loginService.refreshToken();

      if (newToken != null && !JwtDecoder.isExpired(newToken)) {
        debugPrint("✅ Token refreshed successfully, proceeding to Home...");
        await prefs.setString("access_token", newToken);
        return AppRoutes.homePage;
      } else {
        debugPrint("❌ Failed to refresh token, redirecting to Login...");
        return AppRoutes.login;
      }
    }
  }
}
