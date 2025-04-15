import 'package:flutter/material.dart';

import '../../models/questionnaire/questionnaire_model.dart';
import '../../services/questionnaire/questionnaire_service.dart';
import '../../viewmodels/questionnaire/feeling_page_viewmodel.dart';
import '../../viewmodels/questionnaire/mood_page_viewmodel.dart';
import '../../viewmodels/questionnaire/emotion_page_viewmodel.dart';
import '../../utils/routes.dart';
import '../../utils/shared_preferences.dart';

class QuestionnaireViewModel extends ChangeNotifier {
  final QuestionnaireInputService questionnaireInputService =
      QuestionnaireInputService();

  final FeelingViewModel feelingViewModel = FeelingViewModel();
  final MoodViewModel moodViewModel = MoodViewModel();
  final EmotionViewModel emotionViewModel = EmotionViewModel();

  final PageController pageController = PageController();
  int currentPage = 0;

  // Add listeners to child ViewModels
  QuestionnaireViewModel() {
    feelingViewModel.addListener(_notifyListeners);
    moodViewModel.addListener(_notifyListeners);
    emotionViewModel.addListener(_notifyListeners);

    _initializeFromStorage();
  }

  Future<void> _initializeFromStorage() async {
    try {
      // Load feeling
      final feeling = await ApplicationStorage.getFeeling();
      feelingViewModel.selectedValue = feeling;

      // Load mood
      final mood = await ApplicationStorage.getMood();
      if (mood != null) {
        moodViewModel.selectedMood = mood;
      }

      // Load emotions
      final emotions = await ApplicationStorage.getEmotions();
      emotionViewModel.setEmotions(emotions);

      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing from storage: $e');
    }
  }

  // Helper to propagate changes upward
  void _notifyListeners() {
    notifyListeners();
  }

  void goToNextPage(BuildContext context) {
    if (currentPage < 2) {
      // Ensure the current page is validated before proceeding
      if (_validateCurrentPage()) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        currentPage++;
        notifyListeners();
      } else {
        // Show validation error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please complete this page before continuing'),
          ),
        );
      }
    } else {
      submitQuizData(context);
    }
  }

  void goToPreviousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage--;
      notifyListeners();
    }
  }

  bool _validateCurrentPage() {
    switch (currentPage) {
      case 0:
        return feelingViewModel.isValid();
      case 1:
        return moodViewModel.isValid();
      case 2:
        return emotionViewModel.isValid();
      default:
        return false;
    }
  }

  void submitQuizData(BuildContext context) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Get all data from SharedPreferences
    final quizData = await ApplicationStorage.getAllData();

    try {
      final request = QuestionnaireRequest(
        email: quizData['email'],
        feeling: quizData['feeling'],
        mood: quizData['mood'],
        emotion: quizData['emotions'],
      );

      questionnaireInputService.submitQuestionnaire(request);

      // Clear the questionnaire data from SharedPreferences
      await ApplicationStorage.clearQuestionnaireData();

      // Navigate to completion page after submission
      if (context.mounted) {
        Navigator.pushNamed(
          context,
          AppRoutes.completeQuizPage,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Remove listeners to avoid memory leaks
    feelingViewModel.removeListener(_notifyListeners);
    moodViewModel.removeListener(_notifyListeners);
    emotionViewModel.removeListener(_notifyListeners);

    // Dispose child ViewModels
    feelingViewModel.dispose();
    moodViewModel.dispose();
    emotionViewModel.dispose();

    pageController.dispose();
    super.dispose();
  }
}
