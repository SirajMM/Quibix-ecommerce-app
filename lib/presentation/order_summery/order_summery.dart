import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/application/address/address_provider.dart';
import 'package:e_commerce_store/application/cart/cart_provider.dart';
import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/presentation/address/address.dart';
import 'package:e_commerce_store/presentation/cart/widget/cart_listview.dart';
import 'package:e_commerce_store/presentation/order_summery/widgets/adddress_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'widgets/continue_order_button.dart';

class ScreenOrderSummery extends StatelessWidget {
  const ScreenOrderSummery({super.key, required this.totalPrice});
  final int totalPrice;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddressProvider>(context, listen: false).getDefaultAddress();
    });

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
            padding: const EdgeInsets.only(left: 20.0, right: 20.0).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<AddressProvider>(
                    builder: (context, value, child) =>
                        value.selectedAddressId.isNotEmpty
                            ? StreamBuilder(
                                stream: Provider.of<AddressProvider>(context,
                                        listen: false)
                                    .getSelectedAddressStream(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CupertinoActivityIndicator(
                                      radius: 40,
                                    ));
                                  }

                                  if (snapshot.hasError) {
                                    return const Center(
                                        child: Text('Error fetching data'));
                                  }
                                  return AddressCard(data: snapshot.data);
                                })
                            : Container(
                                padding: const EdgeInsets.all(25).r,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Center(
                                      child: Text('No Address were added',
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const ScreenAddAddress(),
                                            ));
                                      },
                                      icon: const Icon(CupertinoIcons.add),
                                      label: const Text(
                                        'Add Address',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  AppConstantsColor
                                                      .materialThemeColor)),
                                    )
                                  ],
                                ),
                              )),
                const SizedBox(height: 10),
                Text(
                  'Items',
                  style:
                      TextStyle(fontSize: 60.sp, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 1100.h,
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .where('id',
                              whereIn: Provider.of<CartProvider>(context,
                                      listen: false)
                                  .ids)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CupertinoActivityIndicator(
                            radius: 40,
                          ));
                        }
                        if (snapshot.hasError) {
                          return const Text('Somthing went wrong');
                        }
                        return CartListView(snapshot: snapshot);
                      }),
                ),
                constSizedBox10,
                ContinueOrderButton(totalPrice: totalPrice),
                constSizedBox10,
              ],
            ),
          ),
        ));
  }
}
