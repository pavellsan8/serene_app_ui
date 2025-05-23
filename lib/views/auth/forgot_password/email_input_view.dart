import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../viewmodels/auth/forgot_password/email_input_viewmodel.dart';
import '../../../widgets/auth/register_textfield_widget.dart';

class EmailInputScreen extends StatelessWidget {
  const EmailInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmailInputViewModel(),
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
          child: Consumer<EmailInputViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Enter your registered email to receive a verification code to reset your password.",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.getFontColor(context),
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 30),
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
                      onPressed: viewModel.isLoading
                          ? null
                          : () => viewModel.validateEmail(context),
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
