import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/routes.dart';
import '../utils/providers.dart';

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
      initialRoute: AppRoutes.splashScreen,
      routes: AppRoutes.getRoutes(),
    );
  }
}
