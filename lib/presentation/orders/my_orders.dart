import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/presentation/orders/widget/oders_custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../application/orders/orders_provider.dart';

class ScreenOrders extends StatefulWidget {
  const ScreenOrders({super.key});

  @override
  State<ScreenOrders> createState() => _ScreenOrdersState();
}

class _ScreenOrdersState extends State<ScreenOrders> {
  @override
  void initState() {
    Provider.of<OrdersProvider>(context, listen: false).getOrderIds();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderHistoryProvider = Provider.of<OrdersProvider>(
      context,
    );

    return Scaffold(
      // backgroundColor: AppConstantsColor.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'My Orders',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.history),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20).r,
          child: orderHistoryProvider.myFields.isNotEmpty
              ? Consumer<OrdersProvider>(
                  builder: (context, value, child) => StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .where('id', whereIn: orderHistoryProvider.myFields)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('An error occurred');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Text('No data found');
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            OdersCustomCard(data: snapshot.data!.docs[index]),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: snapshot.data!.docs.length,
                      );
                    },
                  ),
                )
              : const Center(child: Text('Nothing orderd yet'))),
    );
  }
}
