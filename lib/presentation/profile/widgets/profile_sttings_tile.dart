import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/colors/app_color.dart';

class ProfileSettingsTile extends StatelessWidget {
  const ProfileSettingsTile({
    super.key,
    required this.icons,
    required this.text,
    this.onTap,
    this.color,
  });
  final IconData icons;
  final String text;
  final Function()? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppConstantsColor.lightTextColor,
          boxShadow: const <BoxShadow>[
            BoxShadow(offset: Offset(2, 2), color: Colors.black12),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 60.w,
            ),
            Icon(
              icons,
              color: color ?? Colors.black,
            ),
            const Spacer(),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: color ?? Colors.black),
            ),
            const Spacer(),
            SizedBox(
              width: 80.w,
            ),
          ],
        ),
      ),
    );
  }
}
