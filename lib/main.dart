import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/routes.dart';
import '../viewmodels/auth/get_started_viewmodel.dart';

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
      initialRoute: AppRoutes.questionnaireIntro,
      routes: AppRoutes.getRoutes(),
    );
  }
}
