import 'package:flutter/material.dart' show ChangeNotifier;

class UiProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int i) {
    _currentIndex = i;
    notifyListeners();
  }
}
