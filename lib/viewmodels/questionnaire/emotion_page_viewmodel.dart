import 'package:flutter/material.dart';

class EmotionViewModel extends ChangeNotifier {
  final List<String> _selectedEmotions = [];

  List<String> get selectedEmotions => List.unmodifiable(_selectedEmotions);

  void toggleEmotion(String emotion) {
    if (_selectedEmotions.contains(emotion)) {
      _selectedEmotions.remove(emotion);
    } else {
      _selectedEmotions.add(emotion);
    }
    notifyListeners();
  }

  void setEmotions(List<String> emotions) {
    _selectedEmotions.clear();
    _selectedEmotions.addAll(emotions);
    notifyListeners();
  }

  bool isValid() {
    return _selectedEmotions.isNotEmpty;
  }
}
