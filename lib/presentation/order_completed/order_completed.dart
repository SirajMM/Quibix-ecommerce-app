import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      body: const Center(
          child: Text(
        'No Item Found',
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
