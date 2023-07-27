import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/presentation/payment/widgets/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:upi_india/upi_india.dart';

import '../../application/orders/orders_provider.dart';
import 'functions/payment_functions.dart';

class ScreenPaymet extends StatefulWidget {
  const ScreenPaymet({
    super.key,
  });

  @override
  State<ScreenPaymet> createState() => _ScreenPaymetState();
}

List<UpiApp>? apps;
final _upiIndia = UpiIndia();
Future<UpiResponse>? _transaction;

class _ScreenPaymetState extends State<ScreenPaymet> {
  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          ' Payment Options',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60).r,
        child: ListView(
          children: [
            PaymentOptionsCard(
              image: 'assets/online-payment-vector.jpg',
              text: 'Online Payment',
              onTap: () {
                paymentBottomSheet(
                    context: context,
                    apps: apps!,
                    transaction: _transaction,
                    upiIndia: _upiIndia);
              },
            ),
            constSizedBox20,
            PaymentOptionsCard(
              image: 'assets/images/cash_on_delivery.jpg',
              text: 'Cash On Delivery',
              onTap: () {
                Provider.of<OrdersProvider>(context, listen: false).orderItem();
              },
            ),
          ],
        ),
      ),
    );
  }
}
