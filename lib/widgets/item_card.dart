// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:e_commerce_store/widgets/price_widget.dart';

import '../application/wishlist/wishlist_provider.dart';
import '../presentation/product_detail/product_details_screen.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    this.index, required this.image, required this.name,
  }) : super(key: key);
final String image;
final String name;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => const ScreenProductDetails(),
            ));
      },
      child: Card(
          surfaceTintColor: Colors.transparent,
          color: AppConstantsColor.lightTextColor,
          elevation: 5,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const PriceWidget(fontSize: 22),
                    Consumer<WishListProvider>(
                      builder: (context, value, child) => GestureDetector(
                          onTap: () {
                            // Provider.of
                            //<WishListProvider>(context, listen: false)
                            // WishListProvider wishListProvider = WishListProvider();
                            String itemName = value.items[index!]['name']!;
                            value.addToFav(itemName);
                          },
                          child: value.isExist(value.items[index!]['name']!)
                              ? const Icon(
                                  CupertinoIcons.heart_solid,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  CupertinoIcons.heart,
                                )),
                    )
                  ],
                ),
                Container(
                  height: 110,
                  width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(image))),
                  ),
                
                Row(
                  children: [
                    Text(
                     name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
