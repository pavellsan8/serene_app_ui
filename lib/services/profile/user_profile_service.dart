import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/main/user_profile_model.dart';
import '../../utils/api_url.dart';

class GetUserProfileService {
  Future<UserProfileResponse> fetchUserProfile(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("access_token");

    if (accessToken == null) {
      throw Exception("No access token found.");
    }

    final Uri url =
        Uri.parse("${EnvConfig.baseUrl}/api/v1/user-profile?email=$email");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return UserProfileResponse.fromJson(responseData);
      } else {
        throw Exception("Failed to load user profile");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}