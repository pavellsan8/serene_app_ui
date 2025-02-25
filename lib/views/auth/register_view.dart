import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../viewmodels/auth/register_viewmodel.dart';
import '../../widgets/auth/register_textfield_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<RegisterViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Come join us",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Please register first so we can help with your mental health.",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.fontColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            label: "What's your email address?",
                            hintText: "Enter your email here",
                            controller: viewModel.emailController,
                            onChanged: (_) {},
                            validator: (value) {
                              if (!viewModel.isSubmitted) {
                                return null;
                              }
                              return viewModel.isEmailValid
                                  ? null
                                  : "Invalid email address";
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            label: "What's your password?",
                            hintText: "Enter your email here",
                            controller: viewModel.passwordController,
                            onChanged: (_) {},
                            validator: (value) {
                              if (!viewModel.isSubmitted) return null;
                              return viewModel.isPasswordValid
                                  ? null
                                  : "At least 6 characters required";
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            label: "Confirm your password?",
                            hintText: "Enter your new password here",
                            controller: viewModel.confirmPasswordController,
                            obscureText: true,
                            onChanged: (_) {},
                            validator: (value) {
                              if (!viewModel.isSubmitted) {
                                return null;
                              }
                              if (value == null || value.isEmpty) {
                                return "At least 6 characters required";
                              }
                              if (value != viewModel.passwordController.text) {
                                return "Password did not match";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => viewModel.submit(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
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
