import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isDarkModeEnabled = false;


  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  set isDarkModeEnabled(bool value) {
    _isDarkModeEnabled = value;
    notifyListeners();
  }

}
