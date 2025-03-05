import 'package:flutter/material.dart';
import '../../utils/routes.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isEmailValid = true;
  bool isOtpValid = true;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isSubmitted = false;

  ForgotPasswordViewModel() {
    emailController.addListener(updateFormValidity);
    otpController.addListener(updateFormValidity);
    passwordController.addListener(updateFormValidity);
    confirmPasswordController.addListener(updateFormValidity);
  }

  void updateFormValidity() {
    notifyListeners();
  }

  void validateEmail(BuildContext context) {
    isSubmitted = true;
    isEmailValid = emailController.text.contains("@") &&
        emailController.text.contains(".");

    notifyListeners();

    if (isEmailValid) {
      Navigator.pushNamed(context, AppRoutes.otpInput);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please filled email correctly!"),
        ),
      );
    }
  }

  void validateOtp(BuildContext context) {
    isSubmitted = true;
    isOtpValid = otpController.text.length == 6;

    notifyListeners();

    if (isOtpValid) {
      Navigator.pushNamed(context, AppRoutes.passwordInput);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in the OTP correctly!"),
        ),
      );
    }
  }

  void validatePassword(BuildContext context) {
    isPasswordValid = passwordController.text.length >= 6;
    isConfirmPasswordValid =
        confirmPasswordController.text == passwordController.text;

    notifyListeners();

    if (isPasswordValid && isConfirmPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully reset password!"),
        ),
      );
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

  bool get isFormValid =>
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
