import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:serene_app/utils/colors.dart';
import 'package:serene_app/viewmodels/splash_screen/splash_screen_viewmodel.dart';

// Stateful widget karena ada animasinya
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  // Untuk manage animasinya
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Agar animasinya lebih efisien
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Set up animation controller
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Create entrance animations (scaling)
    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Create entrance animations (fading)
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    );

    // Start entrance animation immediately
    animationController.forward();

    // Create a new animation controller for the exit animation
    Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      navigateToNextPage();
    });
  }

  Future<void> navigateToNextPage() async {
    final splashViewModel = context.read<SplashViewModel>();
    final nextPage = await splashViewModel.checkLoginStatus();

    animationController.reverse().then((_) {
      Navigator.pushReplacementNamed(context, nextPage);
    });
  }

  // Clean animationController to free memory after used
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Center(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Image.asset('assets/images/logo.png', width: 200),
              ),
            ),
          );
        },
      ),
    );
  }
}
