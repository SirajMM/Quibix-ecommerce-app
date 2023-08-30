import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/application/wishlist/wishlist_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../widgets/items_gride.dart';

class ScreenWhishList extends StatefulWidget {
  const ScreenWhishList({Key? key}) : super(key: key);

  @override
  State<ScreenWhishList> createState() => _ScreenWhishListState();
}

final userId = FirebaseAuth.instance.currentUser!.email;

class _ScreenWhishListState extends State<ScreenWhishList> {
  final wishlistRefe =
      FirebaseFirestore.instance.collection('users').doc(userId);

  final List<String> ids = [];

  @override
  Widget build(BuildContext context) {
    // print(wishlistRefe.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'My Wishlist',
          style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.h),
        child: FutureBuilder<List<String>>(
          future: Provider.of<WishListProvider>(context)
              .getdocIds(ids, wishlistRefe),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CupertinoActivityIndicator(
                radius: 40,
              ));
            } else {
              if (ids.isEmpty) {
                return Container(
                  alignment: Alignment.bottomCenter,
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/wishlist.json', height: 400.h),
                      const Text(
                        'Your Wishlist is Empty!',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              }

              return ItemsGrid(
                  products: FirebaseFirestore.instance
                      .collection('products')
                      .where('id', whereIn: ids)
                      .snapshots());
            }
          },
        ),
      ),
    );
  }
}
