import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/routes.dart';
import '../utils/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences safely
  final prefs = await SharedPreferences.getInstance();

  runApp(
    AppProviders.init(
      child: const SereneApp(),
      prefs: prefs,
    ),
  );
}

class SereneApp extends StatelessWidget {
  final SharedPreferences? prefs;

  const SereneApp({super.key, this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.questionnaireIntro,
      routes: AppRoutes.getRoutes(),
    );
  }
}
