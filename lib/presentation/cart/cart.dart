import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/presentation/cart/widget/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'widget/cartFunctions.dart';
import 'widget/checkout_widget.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppConstantsColor.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Cart',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20).r,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => constSizedBox10,
                itemCount: 1,
                itemBuilder: (context, index) => Slidable(
                    endActionPane:
                        ActionPane(motion: const BehindMotion(), children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(10),
                        backgroundColor: AppConstantsColor.materialThemeColor,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (context) {
                          CartFunctions.dialogBuilder(context);
                        },
                      )
                    ]),
                    child: const CartItemCard()),
              ),
            ),
          ),
          Container(
            height: 200.h,
            decoration:
                const BoxDecoration(color: AppConstantsColor.lightTextColor),
            child: Padding(
              padding: EdgeInsets.all(25.r),
              child: const CheckoutWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
