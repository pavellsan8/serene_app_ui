import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../viewmodels/auth/register_viewmodel.dart';
import '../../../widgets/auth/register_textfield_widget.dart';

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
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Please register first so we can help with your mental health.",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.fontBlackColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            label: "What's your name?",
                            hintText: "Enter your name here",
                            controller: viewModel.nameController,
                            onChanged: (_) {},
                            validator: (value) {
                              if (!viewModel.isSubmitted) return null;
                              return viewModel.isNameValid
                                  ? null
                                  : "Please enter at least 5 characters";
                            },
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
                              if (viewModel.emailController.text.isEmpty) {
                                return "Please enter your email address";
                              }
                              return viewModel.isEmailValid
                                  ? null
                                  : "Please enter a valid email address";
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
                      onPressed: () => viewModel.validateNameEmail(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
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
