import 'package:flutter/material.dart';
import '../../utils/routes.dart';

class RegisterViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isNameValid = true;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;
  bool isSubmitted = false;

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
      Navigator.pushNamed(context, AppRoutes.registerPassword);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap isi nama dan email dengan benar!"),
        ),
      );
    }
  }

  void validateStep2(BuildContext context) {
    isPasswordValid = passwordController.text.length >= 6;
    isConfirmPasswordValid =
        confirmPasswordController.text == passwordController.text;

    notifyListeners();

    if (isPasswordValid && isConfirmPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registrasi berhasil!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap isi password dengan benar dan cocok!"),
        ),
      );
    }
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
