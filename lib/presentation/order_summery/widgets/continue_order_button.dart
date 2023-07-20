import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../application/address/address_provider.dart';
import '../../../core/colors/app_color.dart';
import '../../payment/payment_method.dart';

class ContinueOrderButton extends StatelessWidget {
  const ContinueOrderButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
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
            Provider.of<AddressProvider>(context, listen: false)
                    .selectedAddressId
                    .isNotEmpty
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenPaymet(),
                    ))
                : Fluttertoast.showToast(
                    msg: 'Select one address to continue',
                    toastLength: Toast.LENGTH_SHORT,
                  );
          },
          child: const Text(
            'Continue With Order',
            style: TextStyle(fontSize: 25),
          )),
    );
  }
}
