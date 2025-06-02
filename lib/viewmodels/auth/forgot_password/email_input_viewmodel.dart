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

    isLoading = true;
    notifyListeners();

    try {
      final request = EmailOtpRequest(email: emailController.text);
      final response = await _emailOtpInputService.sendOtp(request);
      if (!context.mounted) return;

      serverOtp = response.otpCode.toString().trim();
      if (response.status == 200) {
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

      Navigator.pushNamed(
        context,
        AppRoutes.otpInput,
        arguments: {
          'email': emailController.text,
          'serverOtp': serverOtp,
        },
      );
    } catch (e) {
      debugPrint('Error validating email: $e');
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
