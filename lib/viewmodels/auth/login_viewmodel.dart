import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isPasswordObscured = true;
  bool isSubmitted = false;
  bool rememberMe = false;

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

  void submit(BuildContext context) {
    isSubmitted = true;

    isEmailValid = emailController.text.contains("@") &&
        emailController.text.contains(".");
    isPasswordValid = passwordController.text.length >= 6;

    notifyListeners();

    if (isEmailValid && isPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful: ${emailController.text}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap isi semua field dengan benar!")),
      );
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
