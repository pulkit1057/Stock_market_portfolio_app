import 'package:flutter/material.dart';
import 'package:portfolio_tracker/theme/dark_mode.dart';
import 'package:portfolio_tracker/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData (ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(isDarkMode)
    {
      _themeData = lightMode;
    }
    else
    {
      _themeData = darkMode;
    }
  }
}