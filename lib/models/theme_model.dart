import 'package:flutter/material.dart';

class ThemeOption {
  static final String light = 'light';
  static final String dark = 'dark';
}

class ThemeModel {
  String _currentTheme;
  ThemeData _themeData;

  // constructors
  ThemeModel(this._currentTheme, this._themeData);

  ThemeModel.makeDefault() : this(ThemeOption.light, ThemeData.light());

  factory ThemeModel.fromDB(String theme) {
    return ThemeModel(theme, returnThemeData(theme));
  }

  // translator
  static ThemeData returnThemeData(String theme) {
    return ThemeData(
      scaffoldBackgroundColor: theme == ThemeOption.dark
          ? const Color(0xFF00001a)
          : const Color(0xFFFFFFFF),
      primaryColor: const Color(0xFF120625),
      colorScheme: ThemeData().colorScheme.copyWith(
          secondary: theme == ThemeOption.dark
              ? const Color(0xFF00001a)
              : const Color(0xFFFFFFFF),
          brightness:
              theme == ThemeOption.dark ? Brightness.dark : Brightness.light),
      cardColor: theme == ThemeOption.dark
          ? const Color(0xFF00001a)
          : const Color(0xFFFFFFFF),
      canvasColor:
          theme == ThemeOption.dark ? const Color(0xFF00001a) : Colors.grey[50],
    );
  }

  // getters
  String get currentTheme => _currentTheme;

  ThemeData get themeData => _themeData;

  // setters
  void setTheme(String selection) {
    _currentTheme = selection;
    _themeData = returnThemeData(selection);
  }
}
