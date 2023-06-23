import 'package:e_commerce_store/application/wishlist/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item_card.dart';

class ItemsGrid extends StatelessWidget {
  const ItemsGrid({
    super.key,
    required this.itemCount,
  });

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
          childAspectRatio: 1.0),
      itemBuilder: (context, index) => ItemCard(
          index: index,
          image: Provider.of<WishListProvider>(context).items[index]['image']!,
          name: Provider.of<WishListProvider>(context).items[index]['name']!),
    );
  }
}
