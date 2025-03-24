import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/routes.dart';
import '../../widgets/auth/login_textfield_widget.dart';
import '../../viewmodels/auth/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<LoginViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Image.asset(
                            'assets/images/auth/login.png',
                            height: 200,
                          ),
                          const SizedBox(height: 25),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Let's start with us",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login first so you can meet the experts who can help you.",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.fontBlackColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            label: "Email Address",
                            hintText: "Enter your email here",
                            controller: viewModel.emailController,
                            onChanged: (_) {},
                            validator: (value) {
                              if (!viewModel.isSubmitted) {
                                return null;
                              }
                              if (viewModel.emailController.text.isEmpty) {
                                return "Please enter your email address";
                              }
                              return viewModel.isEmailValid
                                  ? null
                                  : "Please enter a valid email address";
                            },
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            label: "Password",
                            hintText: "Enter your password here",
                            controller: viewModel.passwordController,
                            onChanged: (_) {},
                            validator: (value) {
                              if (!viewModel.isSubmitted) return null;
                              return viewModel.isPasswordValid
                                  ? null
                                  : "At least 6 characters required";
                            },
                            obscureText: viewModel.isPasswordObscured,
                            suffixIcon: IconButton(
                              icon: Icon(
                                viewModel.isPasswordObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: viewModel.togglePasswordVisibility,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.emailInput);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.fontBlueColor,
                                ),
                                child: const Text(
                                  "Forgot your password?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: Consumer<LoginViewModel>(
                            builder: (context, viewModel, child) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: viewModel.isLoading
                                    ? null
                                    : () => viewModel.submit(context),
                                child: viewModel.isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        "Sign In",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.register);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.fontBlueColor,
                              ),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
