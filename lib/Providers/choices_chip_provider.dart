import 'package:flutter/material.dart';

class ChoicesChipProvider extends ChangeNotifier {
  var defaultIndex = 0;

  void changeIndex(int newIndex) {
    defaultIndex = newIndex;
    notifyListeners();
  }
}
