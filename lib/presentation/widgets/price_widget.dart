import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.fontSize,
    required this.price,
  });
  final String price;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$ ',
          style: TextStyle(
              fontSize: fontSize,
              color: AppConstantsColor.materialThemeColor,
              fontWeight: FontWeight.w600),
        ),
        Text(
          price,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
