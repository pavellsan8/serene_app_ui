import 'package:flutter/material.dart';

import '../../../models/auth/forgot_password_model.dart';
import '../../../services/auth/email_input_service.dart';
import '../../../utils/routes.dart';

class OtpInputViewModel extends ChangeNotifier {
  final TextEditingController otpController = TextEditingController();
  final EmailOtpInputService _emailOtpInputService = EmailOtpInputService();
  final String email;
  String? serverOtp;

  bool isOtpValid = true;
  bool isLoading = false;
  bool _isDisposed = false;

  OtpInputViewModel({required this.email, required this.serverOtp});

  void validateOtp(BuildContext context) {
    if (_isDisposed) return;

    final userOtp = otpController.text.trim();
    debugPrint("User OTP: $userOtp, Server OTP: $serverOtp");

    isOtpValid = userOtp == serverOtp;
    if (!_isDisposed) notifyListeners();

    if (isOtpValid) {
      final emailToPass = email;
      final otpToPass = serverOtp;

      otpController.removeListener(() {});
      if (!context.mounted) return;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_isDisposed && context.mounted) {
          Navigator.pushNamed(
            context,
            AppRoutes.passwordInput,
            arguments: {
              'email': emailToPass,
              'serverOtp': otpToPass,
            },
          );
        }
      });
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid OTP! Please check and try again."),
          ),
        );
      }
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    if (_isDisposed) return;

    isLoading = true;
    if (!_isDisposed) notifyListeners();

    try {
      final request = EmailOtpRequest(email: email);
      final response = await _emailOtpInputService.sendOtp(request);

      if (_isDisposed) return;
      if (!context.mounted) return;

      serverOtp = response.otpCode.toString().trim();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
        ),
      );
    } catch (e) {
      if (_isDisposed) return;
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to resend OTP. Please try again."),
        ),
      );
    }

    isLoading = false;
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    otpController.removeListener(() {});

    if (otpController.hasListeners) {
      try {
        otpController.dispose();
      } catch (e) {
        debugPrint("Error disposing otpController: $e");
      }
    }
    super.dispose();
  }
}
