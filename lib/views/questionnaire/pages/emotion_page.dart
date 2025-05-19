import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/questionnaire/continue_btn_widget.dart';
import '../../../widgets/questionnaire/emotion_chip_widget.dart';
import '../../../viewmodels/questionnaire/emotion_page_viewmodel.dart';
import '../../../utils/shared_preferences.dart';

class EmotionsPage extends StatelessWidget {
  final VoidCallback onContinue;

  const EmotionsPage({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final emotionsViewModel = Provider.of<EmotionViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "You can take whatever you like, what you want to know or whatever, and feel free to take it!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: emotionsViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : emotionsViewModel.errorMessage != null
                    ? Center(
                        child: Text(
                          emotionsViewModel.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : Wrap(
                        spacing: 5,
                        runSpacing: 15,
                        children: emotionsViewModel.emotionOptions
                            .map(
                              (emotionData) => EmotionChipWidget(
                                emotion: emotionData.description,
                                isSelected: emotionsViewModel.selectedEmotionIds
                                    .contains(emotionData.feelingId),
                                onTap: () => emotionsViewModel
                                    .toggleEmotion(emotionData.feelingId),
                              ),
                            )
                            .toList(),
                      ),
          ),
          ContinueButton(
            onPressed: () {
              // Save selected IDs to SharedPreferences before continuing
              ApplicationStorage.saveEmotions(
                  emotionsViewModel.selectedEmotionIds);
              onContinue();
            },
          ),
        ],
      ),
    );
  }
}
