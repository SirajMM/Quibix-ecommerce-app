import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/application/product_details/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({
    super.key,
    required this.details,
  });

  final DocumentSnapshot details;

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      height: MediaQuery.sizeOf(context).width * 0.6,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 700.h,
            width: 700.w,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2), shape: BoxShape.circle),
          ),
          Consumer<ProductDetailProvider>(builder: (context, value, child) {
            return CarouselSlider.builder(
              itemCount: widget.details['imageList'].length,
              itemBuilder: (context, index, realIndex) {
                return Hero(
                  tag: widget.details['id'],
                  child: CachedNetworkImage(
                    imageUrl: widget.details['imageList'][index],
                    height: 750.0.h,
                    width: 750.0.w,
                    filterQuality: FilterQuality.high,
                    placeholder: (context, url) => const Center(
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              },
              options: CarouselOptions(
                  enableInfiniteScroll: false,
                  height: 400,
                  onPageChanged: (index, reason) => value.changeIndex(index)),
            );
          }),
        ],
      ),
    );
  }
}
