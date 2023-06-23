import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/presentation/order_summery/widgets/adddress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors/app_color.dart';
import '../cart/widget/cart_item_card.dart';
import '../payment/payment_method.dart';

class ScreenOrderSummery extends StatelessWidget {
  const ScreenOrderSummery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
          title: Text(
            'Orders Summery',
            style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AddressCard(),
                const SizedBox(height: 10),
                Text(
                  'Items',
                  style:
                      TextStyle(fontSize: 60.sp, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                // ignore: avoid_unnecessary_containers
                Container(
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => const CartItemCard(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: 1,
                  ),
                ),
                constSizedBox20,
                Align(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppConstantsColor.materialThemeColor,
                        foregroundColor: AppConstantsColor.lightTextColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScreenPaymet(),
                            ));
                      },
                      child: const Text(
                        'Continue With Order',
                        style: TextStyle(fontSize: 25),
                      )),
                ),
                constSizedBox10,
              ],
            ),
          ),
        ));
  }
}
