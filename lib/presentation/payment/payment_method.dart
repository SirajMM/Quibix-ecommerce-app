import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenPaymet extends StatelessWidget {
  const ScreenPaymet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          ' Payment Options',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
