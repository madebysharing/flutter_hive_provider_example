import 'package:flutter/material.dart';

class ThemeOption{
  static final String light = 'light';
  static final String dark = 'dark';
}

class ThemeModel{
  String _currentTheme;
  ThemeData _themeData;

  // constructors
  ThemeModel(this._currentTheme, this._themeData);

  ThemeModel.makeDefault() :this( ThemeOption.light, ThemeData.light());

  factory ThemeModel.fromDB(String theme){
    return ThemeModel( theme , returnThemeData(theme) );
  }

  // translator
  static ThemeData returnThemeData(String theme){
    return theme == ThemeOption.light ? ThemeData.light() : ThemeData.dark();
  }

  // getters
  String get currentTheme => _currentTheme;

  ThemeData get themeData => _themeData;

  // setters
  void setTheme(String selection){
    _currentTheme = selection;
    _themeData = returnThemeData(selection);
  }
}