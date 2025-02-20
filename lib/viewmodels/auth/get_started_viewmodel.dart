import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;

  Future<void> signInWithGoogle() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithEmail() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();
  }
}
