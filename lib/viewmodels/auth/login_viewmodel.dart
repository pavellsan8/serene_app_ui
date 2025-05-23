import 'package:flutter/material.dart';
import 'package:serene_app/models/auth/login_model.dart';

import '../../services/auth/login_service.dart';
import '../../utils/routes.dart';

class LoginViewModel extends ChangeNotifier {
  // textfield controller login page
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // login service
  final LoginService _loginService = LoginService();

  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isPasswordObscured = true;
  bool isSubmitted = false;
  bool isLoading = false;

  LoginViewModel() {
    emailController.addListener(updateFormValidity);
    passwordController.addListener(updateFormValidity);
  }

  // validasi form login
  void updateFormValidity() {
    final emailText = emailController.text.trim();
    final passwordText = passwordController.text;

    isEmailValid = emailText.isNotEmpty &&
        emailText.contains("@") &&
        emailText.contains(".");
    isPasswordValid = passwordText.isNotEmpty && passwordText.length >= 6;

    notifyListeners();
  }

  // submit button function
  Future<void> onLoginClick(BuildContext context) async {
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
      // request body API
      final request = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final response = await _loginService.loginUser(request);
      if (!context.mounted) return;

      // response API 200
      if (response.status == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
        if (response.data != null &&
            response.data!.submitQuestionnaire == false) {
          // Navigate to questionnaire page if not submitted
          Navigator.pushNamed(
            context,
            AppRoutes.questionnaireIntro,
          );
        } else {
          // Navigate to home page if submitted
          Navigator.pushNamed(
            context,
            AppRoutes.homePage,
          );
        }
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

  // membersihkan resource atau melepaskan controller saat widget dihapus dari widget tree
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
