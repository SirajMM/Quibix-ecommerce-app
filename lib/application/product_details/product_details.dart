// import 'dart:ui';

import 'package:flutter/material.dart';

class ProductDetailProvider extends ChangeNotifier {
  Color? dominantColor;
  int? currentIndex = 0;
  String isSelected = '';
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void selectColor(String color) {
    isSelected = color;
    notifyListeners();
  }
}
