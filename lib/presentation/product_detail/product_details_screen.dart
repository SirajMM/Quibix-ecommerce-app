import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/body_widget.dart';

class ScreenProductDetails extends StatelessWidget {
  const ScreenProductDetails({super.key,required this.details});
  final DocumentSnapshot details;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstantsColor.materialThemeColor,
      appBar: AppBar(
        backgroundColor: AppConstantsColor.lightTextColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.heart),
            ),
          )
        ],
      ),
      body: Body(details: details),
    );
  }
}
