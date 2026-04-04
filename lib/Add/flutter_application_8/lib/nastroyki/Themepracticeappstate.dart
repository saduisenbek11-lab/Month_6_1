import 'package:flutter/material.dart';

class Themepracticeappstate extends ChangeNotifier {
  ThemeMode _thememode = ThemeMode.light;

  ThemeMode get thememode => _thememode;
  bool get isDark => _thememode == ThemeMode.dark;

  void toggleTheme() {
    _thememode = (_thememode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}