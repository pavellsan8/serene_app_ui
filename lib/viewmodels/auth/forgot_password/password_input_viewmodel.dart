import 'package:flutter/material.dart';

import '../../../models/auth/forgot_password_model.dart';
import '../../../services/auth/password_input_service.dart';
import '../../../utils/routes.dart';

class PasswordInputViewmodel extends ChangeNotifier {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final ResetPasswordInputService _resetPasswordInputService =
      ResetPasswordInputService();

  final String email;

  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isSubmitted = false;
  bool isLoading = false;

  PasswordInputViewmodel({required this.email}) {
    passwordController.addListener(updateFormValidity);
    confirmPasswordController.addListener(updateFormValidity);
  }

  void updateFormValidity() {
    isPasswordValid = passwordController.text.length >= 6;
    isConfirmPasswordValid =
        confirmPasswordController.text == passwordController.text;
    notifyListeners();
  }

  // Tambahkan getter untuk mengecek apakah form valid
  bool get isFormValid {
    return passwordController.text.length >= 6 &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text.length >= 6 &&
        passwordController.text == confirmPasswordController.text;
  }

  Future<void> validatePassword(BuildContext context) async {
    isSubmitted = true;
    notifyListeners(); // Update UI untuk menampilkan error messages

    updateFormValidity();

    // Cek apakah form valid sebelum loading
    if (!isFormValid) {
      return; // Keluar tanpa loading jika form tidak valid
    }

    // Baru set loading jika form valid
    isLoading = true;
    notifyListeners();

    try {
      final request = ResetPasswordRequest(
        email: email,
        password: passwordController.text,
      );
      debugPrint("User Email: $email");

      final response = await _resetPasswordInputService.resetPassword(request);
      if (!context.mounted) return;

      // Periksa status dari response
      if (response.status == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.message,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.message,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Password reset failed: ${e.toString()}",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    notifyListeners();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
