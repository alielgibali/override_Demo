import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  bool _isLight = true;
  bool get isLight {
    return _isLight;
  }

  ThemeData get themeData {
    return _themeData;
  }

  // set setheme(ThemeData theme) {
  //   _themeData = theme;
  //   notifyListeners();
  // }
  void changeThemeFunc() {
    _isLight = !_isLight;
    notifyListeners();
  }
}
