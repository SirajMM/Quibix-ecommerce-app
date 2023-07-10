// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:e_commerce_store/application/product_details/product_details.dart';
import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'widgets/cart_button.dart';

class ScreenProductDetails extends StatelessWidget {
  const ScreenProductDetails({super.key, required this.details});
  final details;

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductDetailProvider>(context, listen: true)
        .retrieveDominantColor(details['imageList'][0]);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: double.infinity,
            color: AppConstantsColor.materialThemeColor,
          ),
          Positioned(
            child: Container(
              height: 2050.h,
              decoration: const BoxDecoration(
                color: AppConstantsColor.lightTextColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100.h,
            child: SizedBox(
              height: 180.h,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(CupertinoIcons.back),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.heart),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 500.h,
            child: Consumer<ProductDetailProvider>(
                builder: (context, value, child) {
              return Container(
                height: 750.h,
                width: 750.h,
                decoration: BoxDecoration(
                  color: value.dominantColor?.withOpacity(.2) ??
                      Colors.grey.withOpacity(.2),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
          Positioned(
            top: 280.h,
            child: Image.network(
              details['imageList'][0],
              height: 300,
              width: 300,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 100.h,
            child: const CartButton(),
          ),
        ],
      ),
    );
  }
}
