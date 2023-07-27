import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:order_tracker/order_tracker.dart';

import 'widget/track_order_card.dart';

class ScreenTrackOrder extends StatefulWidget {
  const ScreenTrackOrder({Key? key, required this.data}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  @override
  State<ScreenTrackOrder> createState() => _ScreenTrackOrderState();
}

class _ScreenTrackOrderState extends State<ScreenTrackOrder> {
  List<TextDto> orderList = [
    TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
    TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
    TextDto("Your item has been picked up by courier partner.",
        "Tue, 29th Mar '22 - 5:00pm"),
  ];

  List<TextDto> shippedList = [
    TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
    TextDto("Your item has been received in the nearest hub to you.", null),
  ];

  List<TextDto> outOfDeliveryList = [
    TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
  ];

  List<TextDto> deliveredList = [
    TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          'Track Orders',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: [
            TrackOrderCard(data: widget.data),
            constSizedBox10,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OrderTracker(
                  status: Status.order,
                  activeColor: Colors.green,
                  inActiveColor: Colors.grey[300],
                  orderTitleAndDateList: orderList,
                  shippedTitleAndDateList: shippedList,
                  outOfDeliveryTitleAndDateList: outOfDeliveryList,
                  deliveredTitleAndDateList: deliveredList,
                  subDateTextStyle: const TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
