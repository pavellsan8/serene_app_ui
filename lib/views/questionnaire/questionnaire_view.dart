import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';

import '../../viewmodels/questionnaire/questionnaire_viewmodel.dart';
// import '../../views/questionnaire/pages/feeling_page.dart';
// import '../../views/questionnaire/pages/mood_page.dart';
import '../../views/questionnaire/pages/emotion_page.dart';

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<QuestionnaireViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Opacity(
                      opacity: viewModel.currentPage > 0 ? 1.0 : 0.0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: viewModel.currentPage > 0
                            ? viewModel.goToPreviousPage
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Progress Bar
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(3, (index) {
            //     return Expanded(
            //       child: Container(
            //         margin: const EdgeInsets.symmetric(horizontal: 4.0),
            //         height: 6,
            //         decoration: BoxDecoration(
            //           color: viewModel.currentPage >= index
            //               ? AppColors.primaryColor
            //               : Colors.blue.withAlpha((0.2 * 255).toInt()),
            //           borderRadius: BorderRadius.circular(4),
            //         ),
            //       ),
            //     );
            //   }),
            // ),

            const SizedBox(height: 10),

            // PageView
            Expanded(
              child: PageView(
                controller: viewModel.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // FeelingPage(
                  //   onContinue: () => viewModel.goToNextPage(context),
                  // ),
                  // MoodPage(
                  //   onContinue: () => viewModel.goToNextPage(context),
                  // ),
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
