import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/theme_model.dart';

class ThemeController extends ChangeNotifier{
  final String _dbKey = 'theme';
  Box<dynamic> _db;
  ThemeModel _themeModel;

  // Constructor
  ThemeController(Box<dynamic> db) {
    _db=db;
    // if no theme set, default: light theme
    _themeModel = _db.containsKey(_dbKey) ? ThemeModel.fromDB( _db.get(_dbKey) ) : ThemeModel.makeDefault();
  }

  // Setters
  void setTheme(String selection){
    _themeModel.setTheme(selection);
    _db.put(_dbKey, selection);
    notifyListeners();
  }

  // Getters
  String get currentTheme => _themeModel.currentTheme;

  ThemeData get themeData => _themeModel.themeData;
}