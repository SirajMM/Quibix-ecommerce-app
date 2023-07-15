import 'package:flutter/material.dart';

import '../../../core/colors/app_color.dart';
import 'container_clipper.dart';

class BagroundDesign extends StatelessWidget {
  const BagroundDesign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ContainerClipper(),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              AppConstantsColor.materialThemeColor,
              AppConstantsColor.materialThemeColor2,
            ])),
        height: 290,
        width: double.infinity,
      ),
    );
  }
}
