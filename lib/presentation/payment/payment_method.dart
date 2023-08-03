import 'dart:developer';
import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/presentation/payment/widgets/payment_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../application/orders/orders_provider.dart';
import 'functions/payment_funsctions.dart';

class ScreenPaymet extends StatefulWidget {
  const ScreenPaymet({
    super.key,
    required this.totalPrice,
  });
  final int totalPrice;
  @override
  State<ScreenPaymet> createState() => _ScreenPaymetState();
}

class _ScreenPaymetState extends State<ScreenPaymet> {
  Razorpay? _razorpay;
  _handlePaymentSuccess(PaymentSuccessResponse response) {
    successShowdialog(context, true);
    Provider.of<OrdersProvider>(context, listen: false)
        .orderItemAndDeletFromCart();
    Fluttertoast.showToast(msg: 'PAYMENT SUCCESS ${response.paymentId}');
  }

  _handlePaymentError(PaymentFailureResponse response) {
    successShowdialog(context, false);
    Fluttertoast.showToast(msg: '${response.message}');
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: '${response.walletName}');
  }

  void makePayment() async {
    final user = FirebaseAuth.instance.currentUser;
    var options = {
      'key': 'rzp_test_3FIWDYW5s3iTMq',
      'amount': widget.totalPrice * 100,
      'name': 'Quibix.',
      'description': 'Item',
      'prefill': {'contact': '', 'email': '${user!.email}'}
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

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
                makePayment();
                
              },
            ),
            constSizedBox20,
            PaymentOptionsCard(
              image: 'assets/images/cash_on_delivery.jpg',
              text: 'Cash On Delivery',
              onTap: () {
                successShowdialog(context, true);
                Provider.of<OrdersProvider>(context, listen: false)
                    .orderItemAndDeletFromCart();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _razorpay!.clear();
    super.dispose();
  }
}
