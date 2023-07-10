// ignore_for_file: must_be_immutable
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/colors/app_color.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, int newIndex, _) => CustomNavigationBar(
        currentIndex: newIndex,
        onTap: _onTapped,
        iconSize: 27,
        bubbleCurve: Curves.linear,
        selectedColor: AppConstantsColor.materialThemeColor,
        strokeColor: AppConstantsColor.materialThemeColor,
        unSelectedColor: const Color(0xffacacac),
        backgroundColor: Colors.white,
        scaleFactor: 0.3,
        items: [
          CustomNavigationBarItem(icon: const Icon(CupertinoIcons.home)),
          CustomNavigationBarItem(
              selectedIcon: const Icon(
                CupertinoIcons.heart_solid,
              ),
              icon: const Icon(CupertinoIcons.heart)),
          CustomNavigationBarItem(
              icon: const Icon(CupertinoIcons.shopping_cart)),
          CustomNavigationBarItem(
            icon: const Icon(
              Icons.shopping_bag_outlined,
            ),
          ),
        ],
      ),
    );
  }

  _onTapped(int index) {
    indexChangeNotifier.value = index;
  }
}

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);
