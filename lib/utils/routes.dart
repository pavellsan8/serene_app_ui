import 'package:flutter/material.dart';
import '../views//splash_screen/splash_screen.dart';
import '../views/auth/get_started_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register/personal_page_view.dart';
import '../views/auth/register/password_page_view.dart';
import '../views/auth/forgot_password/email_input_view.dart';
import '../views/auth/forgot_password/otp_input_view.dart';
import '../views/auth/forgot_password/password_input_view.dart';

class AppRoutes {
  static const String splashScreen = '/splash';
  static const String getStarted = '/get_started';
  static const String login = '/login';
  static const String register = '/register';
  static const String registerPassword = '/register_password';
  static const String emailInput = '/email_input';
  static const String otpInput = '/otp_input';
  static const String passwordInput = '/password_input';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashScreen: (context) => const SplashScreen(),
      getStarted: (context) => const GetStartedScreen(),
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      registerPassword: (context) => const RegisterPasswordScreen(),
      emailInput: (context) => const EmailInputScreen(),
      otpInput: (context) => const OtpInputScreen(),
      passwordInput: (context) => const PasswordInputScreen(),
    };
  }
}
