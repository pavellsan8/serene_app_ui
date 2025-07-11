import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/questionnaire/continue_btn_widget.dart';
import '../../../widgets/questionnaire/emotion_chip_widget.dart';
import '../../../viewmodels/questionnaire/questionnaire_viewmodel.dart';
import '../../../utils/shared_preferences.dart';

class EmotionsPage extends StatefulWidget {
  final VoidCallback onContinue;

  const EmotionsPage({super.key, required this.onContinue});

  @override
  State<EmotionsPage> createState() => _EmotionsPageState();
}

class _EmotionsPageState extends State<EmotionsPage> {
  @override
  void initState() {
    super.initState();
    // Use the EmotionViewModel from QuestionnaireViewModel instead of creating a new one
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final questionnaireViewModel =
          Provider.of<QuestionnaireViewModel>(context, listen: false);
      final emotionsViewModel = questionnaireViewModel.emotionViewModel;

      if (!emotionsViewModel.isInitialized && !emotionsViewModel.isLoading) {
        emotionsViewModel.fetchEmotionsWithUserAnswers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionnaireViewModel = Provider.of<QuestionnaireViewModel>(context);
    final emotionsViewModel = questionnaireViewModel.emotionViewModel;

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
                        spacing: 8,
                        runSpacing: 15,
                        alignment: WrapAlignment.center,
                        children: emotionsViewModel.emotionOptions.map(
                          (emotionData) {
                            final isSelected = emotionsViewModel
                                .selectedEmotionIds
                                .contains(emotionData.feelingId);
                            return EmotionChipWidget(
                              emotion: emotionData.description,
                              isSelected: isSelected,
                              onTap: () => emotionsViewModel
                                  .toggleEmotion(emotionData.feelingId),
                            );
                          },
                        ).toList(),
                      ),
          ),
          ContinueButton(
            onPressed: () {
              ApplicationStorage.saveEmotions(
                  emotionsViewModel.selectedEmotionIds);
              widget.onContinue();
            },
          ),
        ],
      ),
    );
  }
}
