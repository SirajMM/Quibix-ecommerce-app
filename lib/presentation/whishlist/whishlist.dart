import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenWhishList extends StatelessWidget {
  const ScreenWhishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'My Whishlist',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          // child: Provider.of<WishListProvider>(context).fav.isNotEmpty
          //     ? const ItemsGrid()
          child: const Center(
            child: Text(
              'Your Whishlist is Empty!.',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )),
    );
  }
}
