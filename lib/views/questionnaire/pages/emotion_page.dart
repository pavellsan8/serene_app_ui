import 'package:flutter/material.dart';
import 'package:serene_app/utils/colors.dart';

import '../../../widgets/questionnaire/continue_btn_widget.dart';

class EmotionsPage extends StatelessWidget {
  final List<String> selectedEmotions;
  final Function(String) onEmotionToggled;
  final VoidCallback onContinue;

  const EmotionsPage({
    super.key,
    required this.selectedEmotions,
    required this.onEmotionToggled,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final emotionOptions = [
      {'text': 'Excited', 'color': Colors.white},
      {'text': 'Energetic', 'color': Colors.white},
      {'text': 'Confident', 'color': Colors.white},
      {'text': 'Joyful', 'color': Colors.white},
      {'text': 'Calm', 'color': Colors.white},
      {'text': 'Peaceful', 'color': Colors.white},
      {'text': 'Grateful', 'color': Colors.white},
      {'text': 'Relaxed', 'color': Colors.white},
      {'text': 'Bored', 'color': Colors.white},
      {'text': 'Lonely', 'color': Colors.white},
      {'text': 'Empty', 'color': Colors.white},
      {'text': 'Overwhelmed', 'color': Colors.white},
      {'text': 'Sad', 'color': Colors.white},
      {'text': 'Anxious', 'color': Colors.white},
      {'text': 'Drained', 'color': Colors.white},
      {'text': 'Frustrated', 'color': Colors.white},
      {'text': 'Worried', 'color': Colors.white},
      {'text': 'Pessimistic', 'color': Colors.white},
      {'text': 'Lost', 'color': Colors.white},
      {'text': 'Hopeless', 'color': Colors.white},
    ];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "You can take whatever you like, what you want to know or whatever, and feel free to take it!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 10,
              children: emotionOptions.map((emotion) => _buildEmotionChip(
                emotion['text'] as String,
                emotion['color'] as Color,
              )).toList(),
            ),
          ),
          ContinueButton(onPressed: onContinue),
        ],
      ),
    );
  }

  Widget _buildEmotionChip(String emotion, Color color) {
    final isSelected = selectedEmotions.contains(emotion);
    final isColoredChip = color != Colors.white;
    
    return GestureDetector(
      onTap: () => onEmotionToggled(emotion),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isColoredChip ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isColoredChip 
                ? color 
                : isSelected ? AppColors.buttonColor : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          emotion,
          style: TextStyle(
            color: isColoredChip 
                ? Colors.white 
                : isSelected ? AppColors.buttonColor : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}