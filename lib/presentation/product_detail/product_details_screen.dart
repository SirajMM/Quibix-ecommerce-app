import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/application/wishlist/wishlist_provider.dart';
import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:e_commerce_store/domain/wishlist/model/wishlist_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/body_widget.dart';

class ScreenProductDetails extends StatelessWidget {
  const ScreenProductDetails({super.key, required this.details});
  final DocumentSnapshot details;
  @override
  Widget build(BuildContext context) {
    // Provider.of<ProductDetailProvider>(context, listen: false)
    //     .retrieveDominantColor(details['imageList'][0]);
    return Scaffold(
      backgroundColor: AppConstantsColor.materialThemeColor,
      appBar: AppBar(
        backgroundColor: AppConstantsColor.lightTextColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.back),
        ),
        actions: [
          FutureBuilder(
              future: Provider.of<WishListProvider>(context)
                  .existInWishlist(details['id']),
              builder: (context, snapshot) {
                final bool itemExists = snapshot.data ?? false;
                return IconButton(
                  onPressed: () {
                    Provider.of<WishListProvider>(context, listen: false)
                        .addToWishlist(WishListModel(id: details['id']));
                  },
                  icon: Icon(
                    !itemExists
                        ? CupertinoIcons.heart
                        : CupertinoIcons.heart_solid,
                    size: 28,
                    color: !itemExists ? null : Colors.red,
                  ),
                );
              }),
        ],
      ),
      body: Body(details: details),
    );
  }
}
