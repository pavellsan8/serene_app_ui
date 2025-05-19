import 'package:flutter/material.dart';

class MoodViewModel extends ChangeNotifier {
  String? _selectedMood;

  // Constructor - can be used to initialize from storage
  // MoodViewModel() {
  //   // You could initialize from preferences here if desired
  //   _loadInitialValue();
  // }

  // Load initial value if needed
  // Future<void> _loadInitialValue() async {
    // This is just a placeholder - in a real implementation
    // you might load from SharedPreferences
    /* 
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedMood = prefs.getString('mood');
      if (savedMood != null && savedMood.isNotEmpty) {
        _selectedMood = savedMood;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading initial mood: $e');
    }
    */
  // }

  String? get selectedMood => _selectedMood;

  set selectedMood(String? value) {
    if (value != _selectedMood) {
      _selectedMood = value;
      notifyListeners();
    }
  }

  bool isValid() {
    final isValid = _selectedMood != null && _selectedMood!.isNotEmpty;
    // debugPrint(
    //     'MoodViewModel.isValid() -> $isValid (selectedMood: $_selectedMood)');
    return isValid;
  }
}
