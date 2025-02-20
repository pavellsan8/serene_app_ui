import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/routes.dart';
import '../viewmodels/auth/get_started_viewmodel.dart';
import '../views/auth/get_started_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.getStarted,
      routes: {
        AppRoutes.getStarted: (context) => const GetStartedScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
      },
    );
  }
}
