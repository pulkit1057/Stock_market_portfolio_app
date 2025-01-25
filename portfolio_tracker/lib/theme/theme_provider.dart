import 'package:flutter/material.dart';
import 'package:portfolio_tracker/theme/dark_mode.dart';
import 'package:portfolio_tracker/theme/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  // bool? dark = prefs.getBool();

  ThemeData _themeData = lightMode;
  ThemeProvider() {
    setup();
  }

  void setup() async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: SharedPreferencesWithCacheOptions(
            allowList: <String>{'theme'}));
    var isDark = prefs.getBool('theme');
    if(isDark == null || isDark == false){
      _themeData = lightMode;
    }
    else{
      _themeData = darkMode;
    }
    notifyListeners();
  }


  bool get isDarkMode => _themeData == darkMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkMode) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }
  }
}
