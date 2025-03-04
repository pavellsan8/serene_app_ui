import 'package:flutter/material.dart';
import 'package:serene_app/utils/providers.dart'; 
import 'utils/routes.dart';

void main() {
  runApp(AppProviders.init(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.main,
      routes: AppRoutes.getRoutes(),
    );
  }
}
