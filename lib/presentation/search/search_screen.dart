import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/search_app_bar.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

List<dynamic> availableProducts = [];
List<dynamic> filteredProducts = [];

class _ScreenSearchState extends State<ScreenSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchCustomAppBar(onChanged: filterUsers),
      body: Padding(
        padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            availableProducts = snapshot.data!.docs;
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: (.3 / .4),
                  ),
                  itemBuilder: (context, index) => ItemCard(
                        allDetails: filteredProducts[index],
                      ));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void filterUsers(String query) {
    setState(() {
      filteredProducts = availableProducts.where((doc) {
        String name = doc.data()['productname'].toLowerCase();
        String searchLower = query.toLowerCase();
        return name.contains(searchLower);
      }).toList();
    });
  }
}
