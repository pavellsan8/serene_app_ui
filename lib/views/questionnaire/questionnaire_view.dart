import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../views/questionnaire/pages/feeling_page.dart';
import '../../views/questionnaire/pages/mood_page.dart';
import '../../views/questionnaire/pages/emotion_page.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedFeelingValue = 3;
  String? _selectedMoodOption;
  final List<String> _selectedEmotions = [];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Questionnaire completed!')),
      );
    }
  }

  void updateFeelingValue(int value) {
    setState(() {
      _selectedFeelingValue = value;
    });
  }

  void updateMoodOption(String mood) {
    setState(() {
      _selectedMoodOption = mood;
    });
  }

  void toggleEmotion(String emotion) {
    setState(() {
      if (_selectedEmotions.contains(emotion)) {
        _selectedEmotions.remove(emotion);
      } else {
        _selectedEmotions.add(emotion);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and skip button
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 16.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Opacity(
                      opacity: _currentPage > 0 ? 1.0 : 0.0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: _currentPage > 0
                            ? () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            : null,
                      ),
                    ),
                  ),

                  // Skip button - always centered in its area
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle skip
                      },
                      child: const Text(
                        'Skip for now >>>',
                        style: TextStyle(
                          color: AppColors.buttonColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Progress indicator below the header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / 3,
                backgroundColor: Colors.blue.withOpacity(0.2),
                color: AppColors.buttonColor,
                minHeight: 6,
              ),
            ),

            const SizedBox(height: 10),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                physics:
                    const NeverScrollableScrollPhysics(),
                children: [
                  // First page - Feeling meter
                  FeelingPage(
                    selectedValue: _selectedFeelingValue,
                    onValueChanged: updateFeelingValue,
                    onContinue: _goToNextPage,
                  ),

                  // Second page - Mood selection
                  MoodPage(
                    selectedMood: _selectedMoodOption,
                    onMoodSelected: updateMoodOption,
                    onContinue: _goToNextPage,
                  ),

                  // Third page - Emotions selection
                  EmotionsPage(
                    selectedEmotions: _selectedEmotions,
                    onEmotionToggled: toggleEmotion,
                    onContinue: _goToNextPage,
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
