import 'package:flutter/material.dart';

class QuestionnaireViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;
  int selectedFeelingValue = 3;
  String? selectedMoodOption;
  final List<String> selectedEmotions = [];

  void goToNextPage() {
    if (currentPage < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage++;
      notifyListeners();
    } else {
      // Handle completion
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

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
