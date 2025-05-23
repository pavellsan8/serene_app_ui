import 'package:flutter/material.dart';

class FeelingViewModel extends ChangeNotifier {
  int? _selectedValue = 1; // Initialize with a default value

  int? get selectedValue => _selectedValue;

  set selectedValue(int? value) {
    _selectedValue = value;
    notifyListeners();
  }

  bool isValid() {
    return _selectedValue != null;
  }
}
