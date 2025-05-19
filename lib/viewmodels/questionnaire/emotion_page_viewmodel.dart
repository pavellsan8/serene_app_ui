import 'package:flutter/material.dart';
import '../../services/questionnaire/emotion_list_service.dart';
import '../../models/questionnaire/emotion_list_model.dart';

class EmotionViewModel extends ChangeNotifier {
  EmotionViewModel() {
    fetchEmotions();
  }

  final EmotionListService _service = EmotionListService();

  List<EmotionListData> _emotionOptions = [];
  final List<int> _selectedEmotionIds = [];

  List<EmotionListData> get emotionOptions =>
      List.unmodifiable(_emotionOptions);
  List<int> get selectedEmotionIds => List.unmodifiable(_selectedEmotionIds);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchEmotions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _service.getEmotionList();
      _emotionOptions = response;
    } catch (e) {
      _errorMessage = "Failed to fetch emotions: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleEmotion(int feelingId) {
    if (_selectedEmotionIds.contains(feelingId)) {
      _selectedEmotionIds.remove(feelingId);
    } else {
      _selectedEmotionIds.add(feelingId);
    }
    notifyListeners();
  }

  void setSelectedEmotions(List<int> ids) {
    _selectedEmotionIds.clear();
    _selectedEmotionIds.addAll(ids);
    notifyListeners();
  }

  bool isValid() {
    return _selectedEmotionIds.isNotEmpty;
  }
}
