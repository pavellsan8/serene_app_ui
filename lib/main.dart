import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:serene_app/viewmodels/auth/get_started_viewmodel.dart';
import 'package:serene_app/views/get_started/get_started_view.dart';

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStartedScreen(),
    );
  }
}
