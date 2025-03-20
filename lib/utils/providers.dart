import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth/login_service.dart';

import '../viewmodels/splash_screen/splash_screen_viewmodel.dart';
import '../viewmodels/splash_screen/get_started_viewmodel.dart';
import '../viewmodels/auth/login_viewmodel.dart';
import '../viewmodels/auth/register_viewmodel.dart';
import '../viewmodels/auth/forgot_password/email_input_viewmodel.dart';

import '../viewmodels/questionnaire/questionnaire_viewmodel.dart';
import '../viewmodels/questionnaire/feeling_page_viewmodel.dart';
import '../viewmodels/questionnaire/mood_page_viewmodel.dart';
import '../viewmodels/questionnaire/emotion_page_viewmodel.dart';
import '../viewmodels/main/profile_page_viewmodel.dart';
import '../viewmodels/auth/logout_viewmodel.dart';

class AppProviders {
  static MultiProvider init(
      {required Widget child, required SharedPreferences prefs}) {
    final loginService = LoginService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SplashViewModel(
            prefs,
            loginService,
          ),
        ),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => EmailInputViewModel()),
        
        ChangeNotifierProvider(create: (_) => QuestionnaireViewModel()),
        ChangeNotifierProvider(create: (_) => FeelingViewModel()),
        ChangeNotifierProvider(create: (_) => MoodViewModel()),
        ChangeNotifierProvider(create: (_) => EmotionViewModel()),
        
        ChangeNotifierProvider(create: (_) => UserProfileViewModel()),
        ChangeNotifierProvider(create: (_) => LogoutViewModel()),
      ],
      child: child,
    );
  }
}
