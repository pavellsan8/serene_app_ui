import 'package:flutter/material.dart';
// import '../views//splash_screen/splash_screen.dart';
import '../views/auth/get_started_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';

import '../views/auth/register_password_view.dart';
import '../views/questionnaire/questionnaire_intro_view.dart';
import '../views/questionnaire/questionnaire_view.dart';

class AppRoutes {
  // static const String splashScreen = '/splash';
  static const String getStarted = '/get_started';
  static const String login = '/login';
  static const String register = '/register';
  static const String registerPassword = '/register_password';

  static const String questionnaireIntro = '/questionnaire_intro';
  static const String questionnairePage = '/questionnaire_section';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      // splashScreen: (context) => const SplashScreen(),
      getStarted: (context) => const GetStartedScreen(),
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      registerPassword: (context) => const RegisterPasswordScreen(),

      questionnaireIntro: (context) => const QuestionnaireIntroScreen(),
      questionnairePage: (context) => const QuestionnaireScreen(),
    };
  }
}
