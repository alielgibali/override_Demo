import 'package:flutter/material.dart';

class Loading with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  void changeLoadingUI() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
