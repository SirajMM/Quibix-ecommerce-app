import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/application/cart/cart_provider.dart';
import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'widget/cart_listview.dart';
import 'widget/checkout_widget.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context, listen: false).getDocId();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Cart',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) => Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20).r,
                child: value.ids.isNotEmpty
                    ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .where('id', whereIn: value.ids)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return const Text('Somthing went wrong');
                          }
                          return CartListView(
                            snapshot: snapshot,
                          );
                        })
                    : const Center(
                        child: Text(
                        'Cart is empty!',
                        style: TextStyle(fontSize: 20),
                      )),
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
      ),
    );
  }
}
