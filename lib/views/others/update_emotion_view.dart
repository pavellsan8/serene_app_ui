import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';

import '../../viewmodels/questionnaire/questionnaire_viewmodel.dart';
import '../../views/questionnaire/pages/emotion_page.dart';

class QuestionnaireUpdateAnswerScreen extends StatelessWidget {
  const QuestionnaireUpdateAnswerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<QuestionnaireViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                // horizontal: 16.0,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(height: 10),

            // PageView
            Expanded(
              child: PageView(
                controller: viewModel.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  EmotionsPage(
                    onContinue: () async {
                      viewModel.submitQuizData(context);
                    },
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
