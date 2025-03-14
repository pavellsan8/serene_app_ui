import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth/get_started_viewmodel.dart';
import '../../widgets/auth/onboarding_widget.dart';
import '../../utils/colors.dart';
import '../../utils/routes.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/auth/welcome_1.png',
      'title': 'Welcome to Serene',
      'description':
          'Join us, you\'ll experience peace of mind knowing that your health is always a priority.',
    },
    {
      'image': 'assets/images/auth/welcome_2.png',
      'title': 'Explore Healing Content',
      'description':
          'Enjoy soothing music, inspiring videos, and insightful books to support your mental well-being.',
    },
    {
      'image': 'assets/images/auth/welcome_3.png',
      'title': 'Your Personal Companion',
      'description':
          'Get support anytime through an intelligent chatbot ready to listen and help you find peace.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    if (authViewModel.currentPage > 0) {
                      authViewModel.goToPage(authViewModel.currentPage - 1);
                    }
                  } else if (details.primaryVelocity! < 0) {
                    if (authViewModel.currentPage < onboardingData.length - 1) {
                      authViewModel.goToPage(authViewModel.currentPage + 1);
                    }
                  }
                },
                child: PageView.builder(
                  controller: authViewModel.pageController,
                  onPageChanged: authViewModel.onPageChanged,
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    return OnboardingPage(
                      image: onboardingData[index]['image']!,
                      title: onboardingData[index]['title']!,
                      description: onboardingData[index]['description']!,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => GestureDetector(
                    onTap: () => authViewModel.goToPage(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 8,
                      width: authViewModel.currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: authViewModel.currentPage == index
                            ? AppColors.primaryColor
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: AppColors.fontBlueColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Don't have an account?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
