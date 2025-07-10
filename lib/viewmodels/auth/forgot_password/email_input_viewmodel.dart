import 'package:flutter/material.dart';

import '../../../models/auth/forgot_password_model.dart';
import '../../../services/auth/email_input_service.dart';
import '../../../utils/routes.dart';

class EmailInputViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final EmailOtpInputService _emailOtpInputService = EmailOtpInputService();

  bool isEmailValid = true;
  bool isSubmitted = false;
  bool isLoading = false;

  String? serverOtp;

  EmailInputViewModel() {
    emailController.addListener(updateFormValidity);
  }

  void updateFormValidity() {
    isEmailValid = emailController.text.contains("@") &&
        emailController.text.contains(".");
    notifyListeners();
  }

  Future<void> validateEmail(BuildContext context) async {
    isSubmitted = true;
    updateFormValidity();

    if (!isEmailValid) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final request = EmailOtpRequest(email: emailController.text);
      final response = await _emailOtpInputService.sendOtp(request);

      if (!context.mounted) return;

      if (response.status == 200) {
        serverOtp = response.otpCode.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.message,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.otpInput,
          (route) => false,
          arguments: {
            'email': emailController.text,
            'serverOtp': serverOtp,
            'nextRoute': AppRoutes.passwordInput,
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.message,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      debugPrint("Error during email validation: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
