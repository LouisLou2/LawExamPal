import 'package:flutter/material.dart';

class StyleProvider extends ChangeNotifier {
  // 现在的模式
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  void setThemeMode(ThemeMode themeMode){
      _themeMode = themeMode;
      notifyListeners();
  }
}