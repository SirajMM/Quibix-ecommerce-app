import 'package:firebase_auth/firebase_auth.dart';
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
            top: 210.h,
            child: PhysicalModel(
              color: Colors.black,
              shape: BoxShape.circle,
              elevation: 3,
              child: CircleAvatar(
                backgroundImage: userImage.isEmpty || userImage == ''
                    ? const AssetImage('assets/images/defaultDp.jpg')
                    : NetworkImage(userImage) as ImageProvider,
                radius: 250.r,
              ),
            ),
          ),
          Positioned(
            top: 570.h,
            left: 590.w,
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

final String userImage = FirebaseAuth.instance.currentUser!.photoURL ?? '';
