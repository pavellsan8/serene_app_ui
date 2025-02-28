import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../widgets/questionnaire/continue_btn_widget.dart';
import '../../../viewmodels/questionnaire/mood_page_viewmodel.dart';

class MoodPage extends StatelessWidget {
  final VoidCallback onContinue;

  const MoodPage({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final moodViewModel = Provider.of<MoodViewModel>(context);

    final moodOptions = ['Happy', 'Depressed', 'Tired', 'Anxious', 'Empty'];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "In one word, which of the following best describes how you've felt over the past month?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 40),
          ...moodOptions
              .map((option) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _buildMoodOption(option, moodViewModel),
                  ))
              .toList(),
          const Spacer(),
          ContinueButton(
            onPressed: moodViewModel.isMoodSelected ? onContinue : () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMoodOption(String option, MoodViewModel viewModel) {
    return InkWell(
      onTap: () => viewModel.selectMood(option),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: viewModel.selectedMood == option
              ? AppColors.buttonColor.withOpacity(0.1)
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: viewModel.selectedMood == option
                ? AppColors.buttonColor
                : Colors.grey.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: viewModel.selectedMood == option
                      ? AppColors.buttonColor
                      : Colors.grey,
                  width: 2.0,
                ),
                color: viewModel.selectedMood == option
                    ? AppColors.buttonColor
                    : Colors.transparent,
              ),
              child: viewModel.selectedMood == option
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Text(
              option,
              style: TextStyle(
                fontSize: 16,
                fontWeight: viewModel.selectedMood == option
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
