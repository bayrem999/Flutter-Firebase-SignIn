import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AppState extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isDarkModeEnabled = false;
  double _fontSize = 16.0;
  FlutterTts? _flutterTts;





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

  double get fontSize => _fontSize;

  set fontSize(double value) {
    _fontSize = value;
    notifyListeners();
  }
}
