import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

final themeProvider =
NotifierProvider<ThemeNotifier, ThemeData>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<ThemeData> {
  @override
  ThemeData build() => lightMode;

  bool get isDarkMode => state == darkMode;

  void toggleTheme() {
    state = state == lightMode ? darkMode : lightMode;
  }

  void setTheme(ThemeData themeData) {
    state = themeData;
  }
}
