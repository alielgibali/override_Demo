import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  bool _isLogin = true;
  bool get isLogin {
    return _isLogin;
  }

  void changeLoginSignUpUI() {
    _isLogin = !_isLogin;
    notifyListeners();
  }
}
