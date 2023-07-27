import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/application/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/colors/app_color.dart';
import '../../../widgets/price_widget.dart';
import 'item_count.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.data,
    required this.index,
  });
  final int index;
  final DocumentSnapshot data;
  @override
  Widget build(BuildContext context) {
    int price = int.parse(data['price']);
    return Material(
      elevation: 3,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.transparent,
      child: Container(
        height: 280.h,
        decoration: const BoxDecoration(
            color: AppConstantsColor.lightTextColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25.0, right: 45, bottom: 15, top: 15)
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
                        data['productname'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 55.sp),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 100.h,
                        width: 350.w,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: AppConstantsColor.materialThemeColor),
                        child: Consumer<CartProvider>(
                            builder: (context, value, child) => ItemCount(
                                  id: data['id'],
                                  index: index,
                                )),
                      ),
                      SizedBox(
                        width: 50.sp,
                      ),
                      Consumer<CartProvider>(
                        builder: (context, value, child) => PriceWidget(
                          fontSize: 24,
                          price: '${value.itemCounts[index] * price}',
                        ),
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
              Container(
                height: 250.h,
                width: 250.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(data['imageList'][0]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
