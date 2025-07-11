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
  bool _isInitialized = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isInitialized => _isInitialized;

  Future<void> fetchEmotions() async {
    _isLoading = true;
    _errorMessage = null;
    _isInitialized = false;
    notifyListeners();

    try {
      final response = await _service.getEmotionList();
      _emotionOptions = response;
      _isInitialized = true;
    } catch (e) {
      _errorMessage = "Failed to fetch emotions: $e";
      debugPrint('Error fetching emotions: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchEmotionsWithUserAnswers() async {
    _isLoading = true;
    _errorMessage = null;
    _isInitialized = false;
    notifyListeners();

    try {
      final emotionsList = await _service.getEmotionList();
      final userAnswers = await _service.getEmotionListUserAnswer();

      _emotionOptions = emotionsList;
      _selectedEmotionIds.clear();

      final uniqueSelectedIds = <int>{};
      for (final answer in userAnswers) {
        uniqueSelectedIds.add(answer.feelingId);
      }

      _selectedEmotionIds.addAll(uniqueSelectedIds);
      debugPrint('Final selected emotion IDs: $_selectedEmotionIds');

      _isInitialized = true;

      // Force UI update
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } catch (e) {
      _errorMessage = "Failed to fetch emotions: $e";
      debugPrint('Error in fetchEmotionsWithUserAnswers: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleEmotion(int feelingId) {
    debugPrint('Toggling emotion with feelingId: $feelingId');

    if (_selectedEmotionIds.contains(feelingId)) {
      _selectedEmotionIds.remove(feelingId);
      debugPrint('Removed feelingId $feelingId from selection');
    } else {
      _selectedEmotionIds.add(feelingId);
      debugPrint('Added feelingId $feelingId to selection');
    }

    debugPrint('Current selected IDs: $_selectedEmotionIds');
    notifyListeners();
  }

  void setSelectedEmotions(List<int> ids) {
    debugPrint('Setting selected emotions: $ids');
    _selectedEmotionIds.clear();
    _selectedEmotionIds.addAll(ids.toSet()); // Remove duplicates
    debugPrint('Selected emotions set to: $_selectedEmotionIds');
    notifyListeners();
  }

  void resetSelections() {
    debugPrint('Resetting selections');
    _selectedEmotionIds.clear();
    notifyListeners();
  }

  bool isValid() {
    final valid = _selectedEmotionIds.isNotEmpty;
    debugPrint(
        'isValid: $valid (selected count: ${_selectedEmotionIds.length})');
    return valid;
  }

  // Helper method to check if specific emotion is selected
  bool isEmotionSelected(int feelingId) {
    return _selectedEmotionIds.contains(feelingId);
  }
}
