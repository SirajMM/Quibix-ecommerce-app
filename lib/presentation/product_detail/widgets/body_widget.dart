import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/presentation/product_detail/widgets/cart_button.dart';
import 'package:e_commerce_store/presentation/product_detail/widgets/slide_indicator.dart';
import 'package:e_commerce_store/widgets/price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_dot.dart';
import 'product_image.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.details,
  });
  final DocumentSnapshot details;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 7,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: AppConstantsColor.lightTextColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProductImage(details: details),
                  details['imageList'].length < 2
                      ? const SizedBox()
                      : SlideIndicator(details: details),
                  details['color'].length != 0
                      ? ColorDot(fillColor: details['color'])
                      : const SizedBox(),
                  Text(
                    details['productname'],
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  constSizedBox10,
                  PriceWidget(fontSize: 25, price: details['price']),
                  constSizedBox10,
                  Text(
                    details['description'],
                    style: const TextStyle(fontSize: 15),
                  ),
                  constSizedBox10,
                ],
              ),
            ),
          ),
          SizedBox(
            height: 200.h,
          ),
          CartButton(product: details),
        ],
      ),
    );
  }
}
