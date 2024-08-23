import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  String _currentTheme = 'system';

  String get currentTheme => _currentTheme;

  set currentTheme(String? theme) {
    _currentTheme = theme ?? 'system';
  }

  ThemeMode get themeMode {
    if (_currentTheme == 'light') return ThemeMode.light;
    if (_currentTheme == 'dark') return ThemeMode.dark;
    return ThemeMode.system;
  }

  changeTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', currentTheme);
    _currentTheme = theme;
    notifyListeners();
  }

  initialaze() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentTheme = prefs.getString('theme');
    notifyListeners();
  }
}
