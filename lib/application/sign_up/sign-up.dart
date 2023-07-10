// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class SignUpProvider extends ChangeNotifier {
  bool _obscureText = true;
  bool _conFirmText = true;
  bool get conFirmText => _conFirmText;
  bool get obscureText => _obscureText;
  void changeObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void confirmChangeObscureText() {
    _conFirmText = !_conFirmText;
    notifyListeners();
  }
}
