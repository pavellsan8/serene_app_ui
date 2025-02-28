import 'package:flutter/material.dart';

class MoodViewModel extends ChangeNotifier {
  String? selectedMood;

  void selectMood(String mood) {
    selectedMood = mood;
    notifyListeners();
  }

  bool get isMoodSelected => selectedMood != null;
}
