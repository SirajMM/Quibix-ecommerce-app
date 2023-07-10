import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: MediaQuery.sizeOf(context).width,
      color: AppConstantsColor.lightTextColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 120).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(CupertinoIcons.back),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.heart),
            )
          ],
        ),
      ),
    );
  }
}
