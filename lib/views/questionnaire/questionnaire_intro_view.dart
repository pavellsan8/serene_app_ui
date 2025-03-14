import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/routes.dart';

class QuestionnaireIntroScreen extends StatelessWidget {
  const QuestionnaireIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 20,
            ),
            // child: TextButton(
            //   onPressed: () {},
            //   child: const Text(
            //     "Skip for now >>>",
            //     style: TextStyle(
            //       fontSize: 14,
            //       fontWeight: FontWeight.w600,
            //       color: AppColors.buttonColor,
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                'assets/images/questionnaire/questionnaire_1.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 50),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Greetings! Please take a few more steps so we can give you the right content!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Your answers are extremely helpful in assisting us in determining the content.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.questionnairePage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Let's Start",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
