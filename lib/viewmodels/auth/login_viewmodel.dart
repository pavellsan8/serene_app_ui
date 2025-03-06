import 'package:flutter/material.dart';

import '../../services/auth/login_service.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginService _loginService = LoginService();

  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isPasswordObscured = true;
  bool isSubmitted = false;
  bool rememberMe = false;
  bool isLoading = false;

  LoginViewModel() {
    emailController.addListener(updateFormValidity);
    passwordController.addListener(updateFormValidity);
  }

  void updateFormValidity() {
    notifyListeners();
  }

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    isSubmitted = true;

    isEmailValid = emailController.text.contains("@") &&
        emailController.text.contains(".");
    isPasswordValid = passwordController.text.length >= 6;

    notifyListeners();

    if (!isEmailValid || !isPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap isi semua field dengan benar!")),
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await _loginService.loginUser(
        emailController.text,
        passwordController.text,
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${response["message"]}")),
      );
      // Navigator.pushNamed(context, AppRoutes.home, arguments: this,);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed: $e")),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    notifyListeners();
  }

  bool get isFormValid =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
