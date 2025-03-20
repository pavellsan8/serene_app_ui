import 'package:flutter/material.dart';

import '../../services/auth/logout_service.dart';
import '../../utils/routes.dart';

class LogoutViewModel extends ChangeNotifier {
  final LogoutService logoutService = LogoutService();
  bool isLoading = false;

  Future<void> logout(BuildContext context) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final response = await logoutService.logoutUser();
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message)),
      );

      if (response.status == 200) {
        Navigator.pushNamed(
          context,
          AppRoutes.getStarted,
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout Failed: ${e.toString()}")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
