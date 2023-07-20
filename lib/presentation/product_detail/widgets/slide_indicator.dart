import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../application/product_details/product_details.dart';

class SlideIndicator extends StatelessWidget {
  const SlideIndicator({
    super.key,
    required this.details,
  });

  final DocumentSnapshot details;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: AnimatedSmoothIndicator(
          effect: const ExpandingDotsEffect(
              dotHeight: 6, dotWidth: 8, activeDotColor: Colors.black),
          activeIndex:
              Provider.of<ProductDetailProvider>(context).currentIndex!,
          count: details['imageList'].length),
    );
  }
}