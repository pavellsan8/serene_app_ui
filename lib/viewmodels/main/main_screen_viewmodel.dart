import 'package:flutter/material.dart';

class MainScreenViewModel extends ChangeNotifier {
  late TabController tabController;

  void initController(TickerProvider vsync) {
    tabController = TabController(length: 5, vsync: vsync);
    notifyListeners();
  }

  void changeTab(int index) {
    tabController.animateTo(index);
    notifyListeners();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
