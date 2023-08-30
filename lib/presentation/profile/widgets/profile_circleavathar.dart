import 'package:e_commerce_store/application/home/home_provider.dart';
import 'package:e_commerce_store/presentation/profile/widgets/image_full_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
              child: Consumer<HomeProvider>(
                builder: (context, value, child) => value.picking != true
                    ? GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FullScreenWidget(image: value.downloadUrl!),
                            )),
                        child: Hero(
                          tag: 'proImage',
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            backgroundImage: value.profileImage(),
                            radius: 250.r,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 250.r,
                        child: const CupertinoActivityIndicator()),
              ),
            ),
          ),
          Positioned(
            top: 570.h,
            left: 590.w,
            child: IconButton(
              onPressed: () {
                context.read<HomeProvider>().pickImage();
              },
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
