import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/application/cart/cart_provider.dart';
import 'package:e_commerce_store/presentation/product_detail/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/colors/app_color.dart';
import '../../widgets/price_widget.dart';
import 'item_count.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    super.key,
    required this.data,
    required this.index,
  });
  final int index;
  final DocumentSnapshot data;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    int price = int.parse(widget.data['price']);
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenProductDetails(details: widget.data),
          )),
      child: Material(
        elevation: 3,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.transparent,
        child: Container(
          height: 280.h,
          decoration: const BoxDecoration(
              color: AppConstantsColor.lightTextColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.only(
                    left: 25.0, right: 45, bottom: 15, top: 15)
                .r,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 700.w,
                        child: Text(
                          widget.data['productname'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 55.sp),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Color: ',
                          style: TextStyle(fontSize: 17),
                        ),
                        FutureBuilder(
                          future: Provider.of<CartProvider>(context)
                              .getCartDetails(widget.data['id']),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Default color');
                            }
                            if (snapshot.data != null) {
                              return Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: Color(int.parse(snapshot.data ?? '')),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }
                            return const Text('Default color');
                          },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 100.h,
                          width: 350.w,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: AppConstantsColor.materialThemeColor),
                          child: Consumer<CartProvider>(
                              builder: (context, value, child) => ItemCount(
                                    id: widget.data['id'],
                                    index: widget.index,
                                  )),
                        ),
                        SizedBox(
                          width: 50.sp,
                        ),
                        Consumer<CartProvider>(
                          builder: (context, value, child) => PriceWidget(
                            fontSize: 24,
                            price: '${value.itemCounts[widget.index] * price}',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                SizedBox(
                  child: CachedNetworkImage(
                      height: 250.h,
                      width: 250.w,
                      placeholder: (context, url) =>
                          const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      imageUrl: widget.data['imageList'][0]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
