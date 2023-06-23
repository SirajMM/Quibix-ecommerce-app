import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors/app_color.dart';
import '../../../core/constants.dart';
import 'custom_text.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700.h,
      width: double.infinity,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            width: .5,
            color: Colors.black,
          ),
        ),
        surfaceTintColor: Colors.transparent,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 20, top: 30).r,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  constSizedBox10,
                  const CustomText(
                      title: 'Street', subTitle: '3512 pearl street'),
                  constSizedBox10,
                  const CustomText(title: 'City', subTitle: 'Nagarcoil'),
                  constSizedBox10,
                  const CustomText(title: 'State', subTitle: 'Tamil Nadu'),
                  constSizedBox10,
                  const CustomText(
                      title: 'Phone number', subTitle: '8870732922'),
                  constSizedBox10,
                  const CustomText(title: 'Zip code', subTitle: '685607'),
                  constSizedBox10,
                  const CustomText(title: 'Country code', subTitle: '+91'),
                  constSizedBox10,
                  const CustomText(title: 'Country', subTitle: 'India'),
                ],
              ),
              Positioned(
                top: 5,
                right: 5,
                height: 25,
                width: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: AppConstantsColor.materialThemeColor,
                    foregroundColor: Colors.white,
                    fixedSize: Size(270.w, 10.h),
                    elevation: 2,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Change',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
