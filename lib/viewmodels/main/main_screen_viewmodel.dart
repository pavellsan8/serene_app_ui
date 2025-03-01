import 'package:flutter/material.dart';

class MainScreenViewModel extends ChangeNotifier {
  late TabController tabController;

  void initController(TickerProvider vsync) {
    tabController = TabController(length: 5, vsync: vsync);
  }

  void changeTab(int index) {
    tabController.index = index;
    notifyListeners();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
