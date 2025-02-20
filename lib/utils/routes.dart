import 'package:flutter/material.dart';

import '../views/get_started/get_started_view.dart';

class AppRoutes {
  static const String getStarted = '/getStarted';
  // static const String home = '/home';
  // static const String register = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case getStarted:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());
      // case home:
      //   return MaterialPageRoute(builder: (_) => const HomeScreen());
      // case register:
      //   return MaterialPageRoute(builder: (_) => const RegisterScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Page Not Found")),
          ),
        );
    }
  }
}
