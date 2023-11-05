import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int tabIndex = 0;

  void changeTab(double tabIndex) {
    this.tabIndex = tabIndex.toInt();
    notifyListeners();
  }
}
