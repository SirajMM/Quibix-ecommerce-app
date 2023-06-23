import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:flutter/material.dart';


class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.fontSize,
  });
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$',
          style: TextStyle(
              fontSize: fontSize,
              color: AppConstantsColor.materialThemeColor,
              fontWeight: FontWeight.w600),
        ),
        Text(
          '200',
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
