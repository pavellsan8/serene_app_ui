import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  // Slider get started logic
  final PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void goToPage(int page) {
    _currentPage = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
