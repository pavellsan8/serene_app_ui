import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/routes.dart';
import '../utils/providers.dart';
import '../utils/colors.dart'; // Make sure to import your colors

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.example.serene_app.channel.audio',
      androidNotificationChannelName: 'Serene Audio Playback',
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true,
    );
    debugPrint("just_audio_background initialized successfully");
  } catch (e) {
    debugPrint("Error initializing just_audio_background: $e");
  }

  // Initialize SharedPreferences safely
  final prefs = await SharedPreferences.getInstance();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  runApp(
    AppProviders.init(
      child: const SereneApp(),
      prefs: prefs,
    ),
  );
}

class SereneApp extends StatelessWidget {
  const SereneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.emailInput,
      routes: AppRoutes.getRoutes(),
      theme: AppColors.lightTheme,
      darkTheme: AppColors.darkTheme,
      themeMode: ThemeMode.system, // This follows device settings
    );
  }
}
