import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/login_or_home/login_or_home.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    goHome(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/Quibixlogo.png',
          height: 750.h,
          width: 750.w,
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  goHome(context) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const LoginOrSignIn()),
    );
  }
}
