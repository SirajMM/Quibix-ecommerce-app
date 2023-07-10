import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  void changeObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
