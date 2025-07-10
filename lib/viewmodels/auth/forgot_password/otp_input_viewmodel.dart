import 'package:flutter/material.dart';
import 'dart:async';

import '../../../models/auth/forgot_password_model.dart';
import '../../../services/auth/email_input_service.dart';

class OtpInputViewModel extends ChangeNotifier {
  final TextEditingController otpController = TextEditingController();
  final EmailOtpInputService _emailOtpInputService = EmailOtpInputService();
  final String email;
  String? serverOtp;
  final String nextRoute;

  bool isOtpValid = true;
  bool isLoading = false;
  bool _isDisposed = false;

  int remainingSeconds = 60;
  bool isResendEnabled = false;
  Timer? _timer;

  OtpInputViewModel({
    required this.email,
    required this.serverOtp,
    required this.nextRoute,
  }) {
    _startTimer();
  }

  void _startTimer() {
    isResendEnabled = false;
    remainingSeconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isDisposed) {
        timer.cancel();
        return;
      }
      if (remainingSeconds > 0) {
        remainingSeconds--;
        notifyListeners();
      } else {
        isResendEnabled = true;
        timer.cancel();
        notifyListeners();
      }
    });
  }

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
          Navigator.pushNamedAndRemoveUntil(
            context,
            nextRoute,
            (route) => false,
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
            content: Text(
              "Invalid OTP! Please check and try again.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        );
      }
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    if (_isDisposed || !isResendEnabled) return;

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
      _startTimer();
    } catch (e) {
      if (_isDisposed) return;
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to resend OTP. Please try again.",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      );
    }

    isLoading = false;
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _timer?.cancel();
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
