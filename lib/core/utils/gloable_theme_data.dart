// Reference:
// https://medium.com/@nikhithsunil/theme-your-flutter-app-a-guide-to-themedata-and-colorscheme-d8bca920a6b5

import 'package:flutter/material.dart';

import 'package:xpensr/core/constants/colors.dart';

///This Class can get same theme data but only change color schema
class GloableThemeData {
  // primary RGB: 0, 33, 59 #00213b拜占庭藍, onPrimary RGB 206, 226, 223 #cee2df 隆河
  // secondary RGB 206, 226, 223 #cee2df 隆河, onSecondary RGB 21, 2, 1 #150201 寒鴉

  static final Color _lightFocusColor = Colors.black.withValues(alpha: 30);
  static final Color _lightBackgroundColor = white90;

  static final Color _darkFocusColor = Colors.white.withValues(alpha: 30);
  static final Color _darkBackgroundColor = black90;

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: byzantiumBlue,
    onPrimary: rhoneBlue,
    secondary: rhoneBlue,
    onSecondary: jackDowBlue,
    surface: Colors.white,
    onSurface: Color.fromARGB(255, 36, 36, 36),
    error: errorRed,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: darkPrimary,
    onPrimary: darkOnPrimary,
    secondary: darkSecondary,
    onSecondary: darkOnSecondary,
    surface: darkSurface,
    onSurface: Colors.white,
    error: errorRed,
    onError: Colors.white,
    brightness: Brightness.dark,
  );

  static ThemeData lightThemeData = themeData(
    colorScheme: lightColorScheme,
    focusColor: _lightFocusColor,
    backgroundColor: _lightBackgroundColor,
  );

  static ThemeData darkThemeData = themeData(
    colorScheme: darkColorScheme,
    focusColor: _darkFocusColor,
    backgroundColor: _darkBackgroundColor,
  );

  /// Return theme data by colorScheme and focus color
  /// Put setting that is common between light mode and dark mode in `defaultThemeData`
  /// focusColor : This color is used by widgets like TextFields and TextFormField to indicate the widget has a primary focus.
  static ThemeData themeData({
    required ColorScheme colorScheme,
    required Color focusColor,
    required Color backgroundColor,
  }) {
    final ThemeData defaultThemeData = ThemeData(
      colorScheme: colorScheme,
      focusColor: focusColor,
      canvasColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      highlightColor: Colors.transparent,
    );
    return defaultThemeData;
  }
}
