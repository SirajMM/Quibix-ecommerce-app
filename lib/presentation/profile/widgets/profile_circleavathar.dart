import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors/app_color.dart';

class ProfieCircleAvathar extends StatelessWidget {
  const ProfieCircleAvathar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 760.h,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: 250.h,
            child: PhysicalModel(
              color: Colors.black,
              shape: BoxShape.circle,
              elevation: 3,
              child: CircleAvatar(
                backgroundImage:
                    const AssetImage('assets/images/defaultDp.jpg'),
                radius: 250.r,
              ),
            ),
          ),
          Positioned(
            top: 570.h,
            left: 560.w,
            child: IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundColor: AppConstantsColor.materialThemeColor,
                child: Icon(
                  CupertinoIcons.camera,
                  color: AppConstantsColor.lightTextColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
