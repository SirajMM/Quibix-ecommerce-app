import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors/app_color.dart';

class ProfileSettingsTile extends StatelessWidget {
  const ProfileSettingsTile({
    super.key,
    required this.icons,
    required this.text,
    this.onTap,
  });
  final IconData icons;
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppConstantsColor.lightTextColor),
        child: Row(
          children: [
            SizedBox(
              width: 60.w,
            ),
            Icon(icons),
            SizedBox(
              width: 170.w,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
