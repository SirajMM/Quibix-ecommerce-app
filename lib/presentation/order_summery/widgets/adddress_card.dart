// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/colors/app_color.dart';
import '../../../core/constants.dart';
import '../../address/address.dart';
import 'custom_text.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.data});
  final  data;
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
                  CustomText(title: 'Name', subTitle: data['name']),
                  constSizedBox10,
                  CustomText(title: 'City', subTitle: data['city']),
                  constSizedBox10,
                  CustomText(title: 'State', subTitle: data['state']),
                  constSizedBox10,
                  CustomText(
                      title: 'Phone number',
                      subTitle: data['phoneNumber'].toString()),
                  constSizedBox10,
                  CustomText(
                      title: 'Pin code', subTitle: data['pin code'].toString()),
                  constSizedBox10,
                  CustomText(
                      title: 'Country code', subTitle: data['country code']),
                  constSizedBox10,
                  CustomText(
                      title: 'Permanent Address',
                      subTitle: data['permanent adress']),
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScreenAddAddress(),
                        ));
                  },
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
