import 'package:flutter/material.dart';
import 'package:serene_app/models/auth/register_model.dart';

import '../../services/auth/register_service.dart';
import '../../utils/routes.dart';

class RegisterViewModel extends ChangeNotifier {
  // textfield controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // register service API
  final RegisterService _registerService = RegisterService();

  bool isNameValid = true;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isSubmitted = false;
  bool isSubmitted2 = false;
  bool isLoading = false;

  RegisterViewModel() {
    nameController.addListener(updateFormValidity);
    emailController.addListener(updateFormValidity);
    passwordController.addListener(updateFormValidity);
    confirmPasswordController.addListener(updateFormValidity);
  }

  // form validation register pages
  void updateFormValidity() {
    isNameValid = nameController.text.length >= 5;
    isEmailValid = emailController.text.contains("@") &&
        emailController.text.contains(".");
    isPasswordValid = passwordController.text.length >= 6;
    isConfirmPasswordValid =
        confirmPasswordController.text == passwordController.text;
    notifyListeners();
  }

  // validation first page
  void validateStep1(BuildContext context) {
    isSubmitted = true;
    updateFormValidity();

    if (!isNameValid || !isEmailValid) {
      return;
    } else {
      Navigator.pushNamed(
        context,
        AppRoutes.registerPassword,
        arguments: this,
      );
    }
  }

  // validation second page
  Future<void> validateStep2(BuildContext context) async {
    isSubmitted2 = true;
    updateFormValidity();

    if (!isPasswordValid || !isConfirmPasswordValid) {
      return;
    }

    try {
      isLoading = true;
      notifyListeners(); 

      final requestData = RegisterRequest(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      final response = await _registerService.registerUser(requestData);

      isLoading = false;
      notifyListeners();
      if (!context.mounted) return;

      if (response.status == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
        Navigator.pushNamed(
          context,
          AppRoutes.login,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
