import 'package:flutter/material.dart';

import '../../services/auth/register_service.dart';
import '../../utils/routes.dart';

class RegisterViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RegisterService _registerService = RegisterService();

  bool isNameValid = true;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isSubmitted = false;
  bool isLoading = false;

  RegisterViewModel() {
    nameController.addListener(updateFormValidity);
    emailController.addListener(updateFormValidity);
    passwordController.addListener(updateFormValidity);
    confirmPasswordController.addListener(updateFormValidity);
  }

  void updateFormValidity() {
    notifyListeners();
  }

  void validateStep1(BuildContext context) {
    isSubmitted = true;
    isNameValid = nameController.text.length >= 5;
    isEmailValid = emailController.text.contains("@") &&
        emailController.text.contains(".");

    notifyListeners();

    if (isNameValid && isEmailValid) {
      Navigator.pushNamed(
        context,
        AppRoutes.registerPassword,
        arguments: this,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap isi nama dan email dengan benar!"),
        ),
      );
    }
  }

  Future<void> validateStep2(BuildContext context) async {
    isPasswordValid = passwordController.text.length >= 6;
    isConfirmPasswordValid =
        confirmPasswordController.text == passwordController.text;

    notifyListeners();

    if (isPasswordValid && isConfirmPasswordValid) {
      try {
        isLoading = true;
        notifyListeners();

        final response = await _registerService.registerUser(
          nameController.text,
          emailController.text,
          passwordController.text,
        );

        isLoading = false;
        notifyListeners();

        if (!context.mounted) return;

        if (response.containsKey('success') && response['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response["message"]),
            ),
          );

          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.login, (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['message']),
            ),
          );
        }
      } catch (e) {
        isLoading = false;
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap isi password dengan benar dan cocok!"),
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
      nameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
