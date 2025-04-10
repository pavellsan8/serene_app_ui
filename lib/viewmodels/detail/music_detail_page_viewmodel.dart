import 'package:flutter/material.dart';

class MusicDetailPageViewModel with ChangeNotifier {
  bool _isFavorite = false;
  bool _isPlaying = false;
  bool _isRepeat = false;

  bool get isFavorite => _isFavorite;
  bool get isPlaying => _isPlaying;
  bool get isRepeat => _isRepeat;

  void toggleFavoriteStatus() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  void togglePlaying() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void toggleRepeat() {
    _isRepeat = !_isRepeat;
    notifyListeners();
  }
}
