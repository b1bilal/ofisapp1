import 'package:flutter/material.dart';

class AdminScreenIndex with ChangeNotifier {
  int _selectedIndex = 0;
  changeIndex(int newValue) {
    _selectedIndex = newValue;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;
}
