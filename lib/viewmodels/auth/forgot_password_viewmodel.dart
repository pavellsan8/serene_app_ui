import 'package:flutter/material.dart';

import '../../services/auth/email_input_service.dart';
import '../../services/auth/password_input_service.dart';
import '../../utils/routes.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final EmailOtpInputService _emailOtpInputService = EmailOtpInputService();

  bool isEmailValid = true;
  bool isOtpValid = true;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isSubmitted = false;
  bool isLoading = false;

  String? serverOtp;
  String? errorMessage;

  ForgotPasswordViewModel() {
    emailController.addListener(updateFormValidity);
    otpController.addListener(updateFormValidity);
    passwordController.addListener(updateFormValidity);
    confirmPasswordController.addListener(updateFormValidity);
  }

  void updateFormValidity() {
    notifyListeners();
  }

  Future<void> validateEmail(BuildContext context) async {
    isSubmitted = true;
    isEmailValid = emailController.text.contains("@") &&
        emailController.text.contains(".");

    notifyListeners();

    if (!isEmailValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email address!"),
        ),
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response =
          await _emailOtpInputService.sendOtp(emailController.text);
      if (!context.mounted) return;

      serverOtp = response["otp_code"].toString().trim();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
        ),
      );

      Navigator.pushNamed(
        context,
        AppRoutes.otpInput,
        arguments: this,
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to send OTP. Please try again."),
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  void validateOtp(BuildContext context) {
    isSubmitted = true;
    final userOtp = otpController.text.trim();
    // print("User OTP: $userOtp, Server OTP: $serverOtp");

    isOtpValid = userOtp == serverOtp;
    notifyListeners();

    if (isOtpValid) {
      Navigator.pushNamed(
        context,
        AppRoutes.passwordInput,
        arguments: this,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP! Please check and try again."),
        ),
      );
    }
  }

  Future<void> validatePassword(BuildContext context) async {
    isPasswordValid = passwordController.text.length >= 6;
    isConfirmPasswordValid =
        confirmPasswordController.text == passwordController.text;

    notifyListeners();

    if (isPasswordValid && isConfirmPasswordValid) {
      try {
        final resetPasswordService = ResetPasswordInputService();

        final response = await resetPasswordService.resetPassword(
          emailController.text,
          passwordController.text,
        );

        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(response["message"] ?? "Successfully reset password!"),
          ),
        );

        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.login, (route) => false);
      } catch (e) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password reset failed: ${e.toString()}"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please check your password again!"),
        ),
      );
    }
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
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
