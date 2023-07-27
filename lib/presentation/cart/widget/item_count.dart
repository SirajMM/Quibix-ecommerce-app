import 'package:e_commerce_store/application/cart/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/colors/app_color.dart';

class ItemCount extends StatelessWidget {
  const ItemCount({
    super.key,
    required this.id,
    required this.index,
  });
  final String id;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    List itemcount =
        cartProvider.itemCounts.isEmpty ? [1] : cartProvider.itemCounts;
    cartProvider.getTotalPrice();
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          splashColor: Colors.black,
          onPressed: () {
            cartProvider.onItemCountDecrement(index, id);
          },
          icon: Icon(
            CupertinoIcons.minus,
            color: AppConstantsColor.lightTextColor,
            size: 65.sp,
          ),
        ),
        Text(
          itemcount[index].toString(),
          style: TextStyle(
              fontSize: 65.sp,
              color: AppConstantsColor.lightTextColor,
              fontWeight: FontWeight.w600),
        ),
        IconButton(
          onPressed: () {
            cartProvider.onItemCountIncrement(index, id);
            debugPrint(itemcount.toString());
          },
          icon: Icon(
            CupertinoIcons.add,
            color: AppConstantsColor.lightTextColor,
            size: 65.sp,
          ),
        ),
      ],
    );
  }
}
