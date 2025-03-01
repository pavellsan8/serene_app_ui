import 'package:flutter/material.dart';
// import '../views//splash_screen/splash_screen.dart';
import '../views/auth/get_started_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';

import '../views/questionnaire/questionnaire_intro_view.dart';
import '../views/questionnaire/questionnaire_view.dart';

import '../views/main/main_screen.view.dart';

class AppRoutes {
  // static const String splashScreen = '/splash';
  static const String getStarted = '/get_started';
  static const String login = '/login';
  static const String register = '/register';

  static const String questionnaireIntro = '/questionnaire_intro';
  static const String questionnaire1 = '/questionnaire_1';

  static const String main = '/main';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      // splashScreen: (context) => const SplashScreen(),
      getStarted: (context) => const GetStartedScreen(),
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),

      questionnaireIntro: (context) => const QuestionnaireIntroScreen(),
      questionnaire1: (context) => const QuestionnaireScreen(),

      main:(context) => const MainScreen(),
    };
  }
}
