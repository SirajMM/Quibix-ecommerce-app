import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/completed_order_card.dart';

class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Completed Orders',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .where('isActive', isEqualTo: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CupertinoActivityIndicator(
                  radius: 20,
                ));
              }
              if (snapshot.hasData) {
                return snapshot.data!.docs.isNotEmpty
                    ? ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => OrderCompleteCard(
                            orderData: snapshot.data!.docs[index]),
                      )
                    : const Center(
                        child: Text(
                        'No Item Found',
                        style: TextStyle(fontSize: 20),
                      ));
              }
              return const Center(
                  child: Text(
                'No Item Found',
                style: TextStyle(fontSize: 20),
              ));
            }),
      ),
    );
  }
}
