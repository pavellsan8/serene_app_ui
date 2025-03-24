import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../viewmodels/auth/forgot_password/password_input_viewmodel.dart';
import '../../../widgets/auth/register_textfield_widget.dart';

class PasswordInputScreen extends StatelessWidget {
  const PasswordInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String email = args['email'] as String;

    return ChangeNotifierProvider(
      create: (_) => PasswordInputViewmodel(email: email),
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
          child: Consumer<PasswordInputViewmodel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Setup your new password",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Create a new password that is easy for you to remember",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.fontBlackColor,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            label: "What's your password?",
                            hintText: "Enter your password here",
                            controller: viewModel.passwordController,
                            onChanged: (_) {},
                            validator: (value) {
                              if (!viewModel.isSubmitted2) return null;
                              return viewModel.isPasswordValid
                                  ? null
                                  : "At least 6 characters required";
                            },
                            obscureText: viewModel.isConfirmPasswordObscured,
                            suffixIcon: IconButton(
                              icon: Icon(
                                viewModel.isConfirmPasswordObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed:
                                  viewModel.toggleConfirmPasswordVisibility,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            label: "Confirm your password?",
                            hintText: "Enter your password again here",
                            controller: viewModel.confirmPasswordController,
                            onChanged: (_) {},
                            validator: (value) {
                              if (!viewModel.isSubmitted2) {
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
                            obscureText: viewModel.isConfirmPasswordObscured,
                            suffixIcon: IconButton(
                              icon: Icon(
                                viewModel.isConfirmPasswordObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed:
                                  viewModel.toggleConfirmPasswordVisibility,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: viewModel.isLoading
                          ? null
                          : () => viewModel.validatePassword(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
