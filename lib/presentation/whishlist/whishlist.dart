import 'package:e_commerce_store/application/wishlist/wishlist_provider.dart';
import 'package:e_commerce_store/widgets/items_gride.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenWhishList extends StatelessWidget {
  const ScreenWhishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Whishlist',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: ItemsGrid(
          itemCount: Provider.of<WishListProvider>(context).fav.length,
        ),
      ),
    );
  }
}
