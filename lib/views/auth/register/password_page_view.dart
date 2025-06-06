import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../viewmodels/auth/register_viewmodel.dart';
import '../../../widgets/auth/register_textfield_widget.dart';

class RegisterPasswordScreen extends StatelessWidget {
  const RegisterPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        ModalRoute.of(context)!.settings.arguments as RegisterViewModel;

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: AppColors.getBackgroundColor(context),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
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
                            "Setup your password",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Set your password so that your account is safe",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.getFontColor(context),
                              fontWeight: FontWeight.w500,
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
                          : () => viewModel.onRegisterClick(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: viewModel.isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
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
