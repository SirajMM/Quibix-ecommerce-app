import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:flutter/material.dart';

import 'widgets/onboarding_clipper.dart';

class ScreenOnBoarding extends StatelessWidget {
  const ScreenOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: OnboardingClipper(),
            child: Container(
              decoration: const BoxDecoration(
                color: AppConstantsColor.materialThemeColor,
              ),
              width: double.infinity,
              height: 500,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(15 / 360),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/8cdbe123010c380e20f264a8fdd57938.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
