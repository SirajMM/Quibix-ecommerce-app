import 'package:e_commerce_store/presentation/main_page/screen_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../core/colors/app_color.dart';
import '../../../core/constants.dart';

Future<dynamic> successShowdialog(BuildContext context, bool successOrFail) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      surfaceTintColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
              successOrFail
                  ? 'assets/success-animation.json'
                  : 'assets/payment_fail_animation.json',
              repeat: successOrFail ? false : true),
          Text(
            successOrFail ? 'Order  Confirmed' : 'Order Failed',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(300.w, 50.h)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
                backgroundColor: MaterialStateProperty.all(successOrFail
                    ? AppConstantsColor.materialThemeColor
                    : Colors.red),
                foregroundColor:
                    MaterialStateProperty.all(AppConstantsColor.darkTextColor)),
            onPressed: () {
              successOrFail
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenMain(),
                      ),
                      (route) => false)
                  : Navigator.pop(context);
            },
            child: Text(
              successOrFail ? 'Go Home' : 'Retry',
              style: TextStyle(
                  fontSize: 15,
                  color: successOrFail
                      ? AppConstantsColor.lightTextColor
                      : Colors.black),
            ),
          ),
          constSizedBox10,
        ],
      ),
    ),
  );
}
