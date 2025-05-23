import 'package:flutter/material.dart';

import '../views/splash_screen/splash_screen.dart';

import '../views/auth/get_started_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register/personal_page_view.dart';
import '../views/auth/register/password_page_view.dart';
import '../views/auth/forgot_password/email_input_view.dart';
import '../views/auth/forgot_password/otp_input_view.dart';
import '../views/auth/forgot_password/password_input_view.dart';

import '../views/questionnaire/questionnaire_intro_view.dart';
import '../views/questionnaire/questionnaire_view.dart';
import '../views/questionnaire/pages/complete_page.dart';

import '../views/main/home_page_view.dart';
import '../views/main/pages/music_page_view.dart';
import '../views/main/pages/video_page_view.dart';
import '../views/main/pages/book_page_view.dart';
import '../views/main/pages/chatbot_page_view.dart';
import '../views/main/pages/profile_page_view.dart';

import '../views/favorite/book_favourite_page_view.dart';
import '../views/favorite/music_favourite_page_view.dart';
import '../views/favorite/video_favourite_page_view.dart';

import '../views/about/about_page_view.dart';

class AppRoutes {
  static const String splashScreen = '/splash';

  static const String getStarted = '/get_started';
  static const String login = '/login';
  static const String register = '/register';
  static const String registerPassword = '/register_password';
  static const String emailInput = '/email_input';
  static const String otpInput = '/otp_input';
  static const String passwordInput = '/password_input';

  static const String questionnaireIntro = '/questionnaire_intro';
  static const String questionnairePage = '/questionnaire_section';
  static const String completeQuizPage = '/complete_question';

  static const String homePage = '/home_page';
  static const String bookPage = '/book_page';
  static const String musicPage = '/music_page';
  static const String videoPage = '/video_page';
  static const String chatbotPage = '/chatbot_page';
  static const String profilePage = '/profile_page';

  static const String bookFavourite = '/book_favourite';
  static const String musicFavourite = '/music_favourite';
  static const String videoFavourite = '/video_favourite';

  static const String aboutPage = '/about_page';

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
      questionnaireIntro: (context) => const QuestionnaireIntroScreen(),
      questionnairePage: (context) => const QuestionnaireScreen(),
      completeQuizPage: (context) => const CompletePage(),
      homePage: (context) => const HomePage(),
      bookPage: (context) => const BookPage(),
      musicPage: (context) => const MusicPage(),
      videoPage: (context) => const VideoPage(),
      chatbotPage: (context) => const ChatbotPage(),
      profilePage: (context) => const ProfilePage(),
      bookFavourite: (context) => const BookFavouritesPage(),
      musicFavourite: (context) => const MusicFavouritesPage(),
      videoFavourite: (context) => const VideoFavouritesPage(),
      aboutPage: (context) => const AboutUsPage(),
    };
  }
}
