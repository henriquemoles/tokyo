// lib/core/theme/theme_controller.dart
import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.light);

  ValueNotifier<ThemeMode> get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode.value =
        _themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
