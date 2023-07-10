import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/presentation/address/widgets/new_address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors/app_color.dart';

class ScreenAddAddress extends StatelessWidget {
  const ScreenAddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Address',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => const AddAddressCard(),
                  separatorBuilder: (context, index) => constSizedBox10,
                  itemCount: 1),
            ),
            constSizedBox10,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: AppConstantsColor.materialThemeColor,
                foregroundColor: Colors.white,
                fixedSize: Size(270.w, 10.h),
                elevation: 2,
              ),
              onPressed: () {},
              child: const Text(
                'Add',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
