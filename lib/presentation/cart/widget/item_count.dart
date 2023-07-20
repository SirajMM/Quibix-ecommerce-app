import 'package:e_commerce_store/application/cart/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/colors/app_color.dart';

class ItemCount extends StatelessWidget {
  const ItemCount({
    super.key,
    required this.data,
  });
  final data;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        cartProvider.itemCount > 1
            ? InkWell(
                splashColor: Colors.black,
                onTap: () {
                  cartProvider.onItemCountDecrement();
                },
                child: Icon(
                  CupertinoIcons.minus,
                  color: AppConstantsColor.lightTextColor,
                  size: 65.sp,
                ),
              )
            : Icon(
                Icons.remove,
                color: Colors.grey,
                size: 65.sp,
              ),
        Text(
          cartProvider.itemCount.toString(),
          style: TextStyle(
              fontSize: 65.sp,
              color: AppConstantsColor.lightTextColor,
              fontWeight: FontWeight.w600),
        ),
        InkWell(
          onTap: () {
            cartProvider.onItemCountIncrement(data);
          },
          child: Icon(
            CupertinoIcons.add,
            color: AppConstantsColor.lightTextColor,
            size: 65.sp,
          ),
        ),
      ],
    );
  }
}
