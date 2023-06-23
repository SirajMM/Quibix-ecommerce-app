// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class WishListProvider extends ChangeNotifier {
  List<Map<String, String>> fav = [];
  List<Map<String, String>> items = [
    {'name': 'Headphones', 'image': 'assets/images/headphones.jpg'},
    {'name': 'Tv', 'image': 'assets/images/gconnect1.jpg'},
    {'name': 'Watch', 'image': 'assets/images/image1.png'},
    {'name': 'Laptop', 'image': 'assets/images/images.jpg'},
    {'name': 'Phone', 'image': 'assets/images/08_Galaxy-S23-Ultra_Cream.webp'},
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
