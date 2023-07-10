// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class WishListProvider extends ChangeNotifier {
  List<Map<String, String>> fav = [];
  List<Map<String, String>> items = [
   
  ];

  void addToFav(String name) {
    bool contains = fav.any((item) => item['name'] == name);
    if (contains) {
      fav.removeWhere((item) => item['name'] == name);
    } else {
      Map<String, String> item = items.firstWhere(
        (item) => item['name'] == name,
      );
      if (item != null) {
        fav.add(item);
      }
    }
    notifyListeners();
  }

  bool isExist(String name) {
    bool exist = fav.any((item) => item['name'] == name);

    return exist;
  }
}
