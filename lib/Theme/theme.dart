import 'package:color_blindness/color_blindness_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:color_blindness/color_blindness.dart';
import '../screens/Home/AppState.dart';

final ColorScheme highContrastColorScheme = ColorScheme(
  primary: Colors.black,
  primaryVariant: Colors.black,
  secondary: Colors.white,
  secondaryVariant: Colors.white,
  surface: Colors.black,
  background: Colors.white,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.white,
  onBackground: Colors.black,
  onError: Colors.white,
  brightness: Brightness.dark,
);



/*final ColorScheme colorBlindColorScheme = ColorScheme(
  primary: Colors.blue,  // Change to a color that is more distinguishable
  primaryVariant: Colors.blue,
  secondary: Colors.orange,  // Change to a color that is more distinguishable
  secondaryVariant: Colors.orange,
  surface: Colors.black,
  background: Colors.white,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.white,
  onBackground: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,  // Use a suitable brightness for color-blind mode
);*/

ThemeData getAppTheme(AppState appState) {
  if (appState.isHighContrastModeEnabled) {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: highContrastColorScheme,
      // ... other properties ...
    );
  } else if (appState.isColorBlindModeEnabled) {
    return ThemeData(
      brightness: Brightness.dark,
        colorScheme: colorBlindnessColorScheme(ColorScheme.dark(), ColorBlindnessType.protanomaly) ,// Use the color-blind color scheme
      // ... other properties ...
    );
  } else if (appState.isDarkModeEnabled) {
    return ThemeData.dark();
  } else {
    return ThemeData.light();
  }
}




