import 'package:flutter/material.dart';
import 'package:serene_app/models/auth/login_model.dart';

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
    isEmailValid = emailController.text.contains("@") &&
        emailController.text.contains(".");
    isPasswordValid = passwordController.text.length >= 6;
    notifyListeners();
  }

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    isSubmitted = true;

    isLoading = true;
    updateFormValidity();

    try {
      final request = LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      );
      final response = await _loginService.loginUser(request);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message)),
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
