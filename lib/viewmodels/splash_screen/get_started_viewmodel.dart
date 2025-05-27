import 'dart:async';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  // Slider get started logic
  final PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _autoSlideTimer;
  static const Duration _autoSlideDuration = Duration(seconds: 3);
  static const int _totalPages = 3;

  int get currentPage => _currentPage;

  AuthViewModel() {
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(_autoSlideDuration, (timer) {
      if (_currentPage < _totalPages - 1) {
        goToPage(_currentPage + 1);
      } else {
        goToPage(0);
      }
    });
  }

  void _stopAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = null;
  }

  void _restartAutoSlide() {
    _stopAutoSlide();
    _startAutoSlide();
  }

  void goToPage(int page) {
    _currentPage = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    notifyListeners();

    _restartAutoSlide();
  }

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  // Pause auto slide (misal saat user interact)
  void pauseAutoSlide() {
    _stopAutoSlide();
  }

  // Resume auto slide
  void resumeAutoSlide() {
    _startAutoSlide();
  }

  @override
  void dispose() {
    _stopAutoSlide();
    pageController.dispose();
    super.dispose();
  }
}
