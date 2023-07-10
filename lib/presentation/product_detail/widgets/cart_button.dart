import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors/app_color.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          elevation: MaterialStateProperty.all<double?>(3),
          foregroundColor: MaterialStateProperty.all<Color?>(
              AppConstantsColor.materialThemeColor),
          backgroundColor: MaterialStateProperty.all<Color?>(
              AppConstantsColor.lightTextColor),
          fixedSize: MaterialStateProperty.all(Size(600.w, 120.h)),
        ),
        onPressed: () {},
        icon: const Icon(Icons.shopping_cart),
        label: const Text('Add To Cart'));
  }
}
