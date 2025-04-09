import 'package:flutter/material.dart';

class MoodViewModel extends ChangeNotifier {
  String? _selectedMood;

  String? get selectedMood => _selectedMood;

  set selectedMood(String? value) {
    _selectedMood = value;
    notifyListeners();
  }

  bool isValid() {
    return _selectedMood!.isNotEmpty;
  }
}
