import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/main/user_profile_model.dart';
import '../../services/profile/user_profile_service.dart';

class UserProfileViewModel extends ChangeNotifier {
  final GetUserProfileService _userProfileService = GetUserProfileService();

  UserData? userData;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchUserProfile() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await Future.delayed(
        const Duration(milliseconds: 1),
      ); // Small delay for safety

      String? email = prefs.getString("email");
      debugPrint('Retrieved email: $email');

      if (email == null) {
        errorMessage = "No email found.";
        isLoading = false;
        notifyListeners();
        return;
      }

      final response = await _userProfileService.fetchUserProfile(email);
      userData = response.data;
    } catch (e) {
      errorMessage = "Failed to fetch user data: $e";
    }

    isLoading = false;
    notifyListeners();
  }
}
