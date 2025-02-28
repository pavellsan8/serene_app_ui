import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/questionnaire/continue_btn_widget.dart';
import '../../../widgets/questionnaire/emotion_chip_widget.dart';
import '../../../viewmodels/questionnaire/emotion_page_viewmodel.dart';

class EmotionsPage extends StatelessWidget {
  final VoidCallback onContinue;

  const EmotionsPage({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final emotionsViewModel = Provider.of<EmotionViewModel>(context);

    final emotionOptions = [
      'Excited',
      'Energetic',
      'Confident',
      'Joyful',
      'Calm',
      'Peaceful',
      'Grateful',
      'Relaxed',
      'Bored',
      'Lonely',
      'Empty',
      'Overwhelmed',
      'Sad',
      'Anxious',
      'Drained',
      'Frustrated',
      'Worried',
      'Pessimistic',
      'Lost',
      'Hopeless',
    ];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "You can take whatever you like, what you want to know or whatever, and feel free to take it!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 10,
              children: emotionOptions
                  .map((emotion) => EmotionChipWidget(
                        emotion: emotion,
                        viewModel: emotionsViewModel,
                      ))
                  .toList(),
            ),
          ),
          ContinueButton(onPressed: onContinue),
        ],
      ),
    );
  }
}
