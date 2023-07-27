import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upi_india/upi_india.dart';

Future<void> paymentBottomSheet(
    {required context,
    required List<UpiApp> apps,
    required Future<UpiResponse>? transaction,
    required UpiIndia upiIndia}) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: ListView(
          children: [
            const Text(
              'Choose the option to continue',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Wrap(
              children: apps.map<Widget>((UpiApp app) {
                return GestureDetector(
                  onTap: () {
                    transaction = initiateTransaction(app, upiIndia);
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.memory(
                          app.icon,
                          height: 60,
                          width: 60,
                        ),
                        Text(app.name),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
          ],
        ),
      );
    },
  );
}

Future<UpiResponse> initiateTransaction(UpiApp app, upiIndia) async {
  return upiIndia.startTransaction(
    app: app,
    receiverUpiId: "sirajmuhammed718@okicici",
    receiverName: 'Quibix',
    transactionRefId: 'TestingUpiIndiaPlugin',
    // transactionNote: 'Not actual. Just an example.',
    amount: 1.00,
  );
}
