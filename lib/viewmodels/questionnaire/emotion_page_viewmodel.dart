import 'package:flutter/material.dart';

class EmotionViewModel extends ChangeNotifier {
  List<String> selectedEmotions = [];

  void toggleEmotion(String emotion) {
    if (selectedEmotions.contains(emotion)) {
      selectedEmotions.remove(emotion);
    } else {
      selectedEmotions.add(emotion);
    }
    notifyListeners(); 
  }

  bool isEmotionSelected(String emotion) {
    return selectedEmotions.contains(emotion);
  }
}
