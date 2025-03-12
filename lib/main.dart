import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/routes.dart';
import '../viewmodels/auth/get_started_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences safely
  SharedPreferences? prefs;
  try {
    prefs = await SharedPreferences.getInstance();
  } catch (e) {
    debugPrint("Error initializing SharedPreferences: $e");
  }

  runApp(
    MyApp(prefs: prefs),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences? prefs;

  const MyApp({super.key, this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
