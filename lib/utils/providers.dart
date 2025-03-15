import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth/get_started_viewmodel.dart';
import '../viewmodels/auth/login_viewmodel.dart';
import '../viewmodels/auth/register_viewmodel.dart';
import '../viewmodels/auth/forgot_password/email_input_viewmodel.dart';

class AppProviders {
  static MultiProvider init({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => EmailInputViewModel()),
      ],
      child: child,
    );
  }
}
