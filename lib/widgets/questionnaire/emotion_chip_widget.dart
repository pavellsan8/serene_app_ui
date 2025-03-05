import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../viewmodels/questionnaire/emotion_page_viewmodel.dart';

class EmotionChipWidget extends StatelessWidget {
  final String emotion;
  final EmotionViewModel viewModel;

  const EmotionChipWidget({
    super.key,
    required this.emotion,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = viewModel.isEmotionSelected(emotion);

    return GestureDetector(
      onTap: () => viewModel.toggleEmotion(emotion),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          emotion,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
