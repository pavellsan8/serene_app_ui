import 'package:flutter/material.dart';

import '../../models/main/user_profile_model.dart';
import '../../services/main/user_profile_service.dart';
import '../../utils/shared_preferences.dart';

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
      final email = await ApplicationStorage.getEmail();
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
