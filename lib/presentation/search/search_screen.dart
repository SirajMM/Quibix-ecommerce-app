// ignore_for_file: prefer_interpolation_to_compose_strings

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

QuerySnapshot<Map<String, dynamic>>? _searchResults;

class _ScreenSearchState extends State<ScreenSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchCustomAppBar(
        onChanged: _performSearch,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
        child: _buildSearchResults(),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults == null) {
      return const Center(
        child: Text(
          'Search Products',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    if (_searchResults!.docs.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(fontSize: 20),
        ),
      );
    }
    return GridView.builder(
      itemCount: _searchResults!.docs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: 2,
        childAspectRatio: (.3 / .4),
      ),
      itemBuilder: (context, index) => ItemCard(
        allDetails: _searchResults!.docs[index],
      ),
    );
  }

  void _performSearch(String query) async {
    CollectionReference productsCollection =
        FirebaseFirestore.instance.collection('products');

    QuerySnapshot<Map<String, dynamic>> searchResults = await productsCollection
        .where('productname', isGreaterThanOrEqualTo: query.trim())
        .where('productname', isLessThan: query.trim() + 'z')
        .get() as QuerySnapshot<Map<String, dynamic>>;
    setState(() {
      _searchResults = searchResults;
    });
  }
}
