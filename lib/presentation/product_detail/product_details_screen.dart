import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:flutter/material.dart';

class ScreenProductDetails extends StatelessWidget {
  const ScreenProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        elevation: 0.0,
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: AppConstantsColor.materialThemeColor,
          ),
          Positioned(
            child: Container(
              height: 650,
              decoration: const BoxDecoration(
                  color: AppConstantsColor.lightTextColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
            ),
          ),
        ],
      ),
    );
  }
}
