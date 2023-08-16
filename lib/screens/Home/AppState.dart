import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sign_in/Models/Font.dart';

class AppState extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isDarkModeEnabled = false;
  double _fontSize = 16.0;
  FlutterTts? _flutterTts;
  bool _isHighContrastModeEnabled = false; // Set the initial value as needed
  bool get isHighContrastModeEnabled => _isHighContrastModeEnabled;
  bool _isColorBlindModeEnabled = false;
  Locale _appLocale = Locale('en'); // Default app language

  Locale get appLocale => _appLocale;
   // Set a default font

  AppFont _selectedFont = AppFont.roboto;

  AppFont get selectedFont => _selectedFont;

  void changeFont(AppFont newFont) {
    _selectedFont = newFont;
    notifyListeners();
  }

  void setAppLanguage(Locale newLocale) {
    _appLocale = newLocale;
    notifyListeners();
  }







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



  set isHighContrastModeEnabled(bool value) {
    _isHighContrastModeEnabled = value;
    notifyListeners();
  }

  bool get isColorBlindModeEnabled => _isColorBlindModeEnabled;

  set isColorBlindModeEnabled(bool value) {
    _isColorBlindModeEnabled = value;
    notifyListeners();
  }

  void toggleHighContrastMode() {
    _isHighContrastModeEnabled = !_isHighContrastModeEnabled;
    notifyListeners();
  }
}
