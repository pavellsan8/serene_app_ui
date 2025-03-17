import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth/get_started_viewmodel.dart';
import '../viewmodels/auth/login_viewmodel.dart';
import '../viewmodels/auth/register_viewmodel.dart';
import '../viewmodels/auth/forgot_password/email_input_viewmodel.dart';

import '../viewmodels/questionnaire/questionnaire_viewmodel.dart';
import '../viewmodels/questionnaire/feeling_page_viewmodel.dart';
import '../viewmodels/questionnaire/mood_page_viewmodel.dart';
import '../viewmodels/questionnaire/emotion_page_viewmodel.dart';

import '../viewmodels/main/book_page_viewmodel.dart';

import '../viewmodels/auth/logout_viewmodel.dart';

class AppProviders {
  static MultiProvider init({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => EmailInputViewModel()),

        ChangeNotifierProvider(create: (_) => QuestionnaireViewModel()),
        ChangeNotifierProvider(create: (_) => FeelingViewModel()),
        ChangeNotifierProvider(create: (_) => MoodViewModel()),
        ChangeNotifierProvider(create: (_) => EmotionViewModel()),

        ChangeNotifierProvider(create: (_) => BookPageViewModel()),
        
        ChangeNotifierProvider(create: (_) => LogoutViewModel()),
      ],
      child: child,
    );
  }
}
