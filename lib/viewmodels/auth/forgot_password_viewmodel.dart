import 'package:flutter/material.dart';

import '../../models/auth/forgot_password_model.dart';
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
  final ResetPasswordInputService _resetPasswordInputService =
      ResetPasswordInputService();

  bool isEmailValid = true;
  bool isOtpValid = true;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isSubmitted = false;
  bool isSubmitted2 = false;
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
    isEmailValid = emailController.text.contains("@") &&
        emailController.text.contains(".");
    isPasswordValid = passwordController.text.length >= 6;
    isConfirmPasswordValid =
        confirmPasswordController.text == passwordController.text;
    notifyListeners();
  }

  Future<void> validateEmail(BuildContext context) async {
    isSubmitted = true;
    updateFormValidity();

    isLoading = true;
    notifyListeners();

    try {
      final request = EmailOtpRequest(email: emailController.text);
      final response = await _emailOtpInputService.sendOtp(request);
      if (!context.mounted) return;

      serverOtp = response.otpCode.toString().trim();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
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
    isSubmitted2 = true;
    isLoading = true;
    notifyListeners();

    try {
      final request = ResetPasswordRequest(
        email: emailController.text,
        password: passwordController.text,
      );
      final response = await _resetPasswordInputService.resetPassword(request);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password reset failed: ${e.toString()}"),
        ),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> resendOtp(BuildContext context) async {
    if (!isEmailValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email before resending OTP!"),
        ),
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final request = EmailOtpRequest(email: emailController.text);
      final response = await _emailOtpInputService.sendOtp(request);
      if (!context.mounted) return;

      serverOtp = response.otpCode.toString().trim();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to resend OTP. Please try again."),
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
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
