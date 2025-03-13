import 'package:flutter/material.dart';
import 'package:serene_app/models/auth/login_model.dart';

import '../../services/auth/login_service.dart';
import '../../utils/routes.dart';

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
    final emailText = emailController.text.trim();
    final passwordText = passwordController.text;

    isEmailValid = emailText.isNotEmpty &&
        emailText.contains("@") &&
        emailText.contains(".");
    isPasswordValid = passwordText.isNotEmpty && passwordText.length >= 6;

    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    if (isLoading) return;

    isSubmitted = true;
    notifyListeners();

    updateFormValidity();
    if (!isEmailValid || !isPasswordValid) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final request = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      final response = await _loginService.loginUser(request);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message)),
      );

      if (response.status == 200) {
        Navigator.pushNamed(
          context,
          AppRoutes.questionnaireIntro,
          arguments: this,
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed: ${e.toString()}")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
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
