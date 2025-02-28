import 'package:flutter/material.dart';

class FeelingViewModel extends ChangeNotifier {
  int _selectedValue = 3;

  int get selectedValue => _selectedValue;

  void updateFeelingValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }
}
