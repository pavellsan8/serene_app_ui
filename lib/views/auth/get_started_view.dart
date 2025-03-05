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
      'title': 'Meet the experts',
      'description': 'Consult your complaint with an expert in the field.',
    },
    {
      'image': 'assets/images/auth/welcome_3.png',
      'title': 'Experts around the world',
      'description': 'Experts from around the world are here for you.',
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
                      authViewModel
                          .goToPage(authViewModel.currentPage - 1);
                    }
                  } else if (details.primaryVelocity! < 0) {
                    if (authViewModel.currentPage <
                        onboardingData.length - 1) {
                      authViewModel
                          .goToPage(authViewModel.currentPage + 1);
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

            // Enhanced page indicator
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

            // Buttons stay at the bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: authViewModel.isLoading
                          ? null
                          : () {
                              authViewModel.signInWithGoogle();
                            },
                      icon: Image.asset(
                        'assets/icons/icon_google.png',
                        height: 24,
                      ),
                      label: authViewModel.isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Continue with Google"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Continue with Email",
                        style: TextStyle(color: Colors.white),
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
