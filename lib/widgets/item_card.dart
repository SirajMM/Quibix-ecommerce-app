// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_store/core/constants.dart';
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
    this.allDetails,
  }) : super(key: key);

  final allDetails;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => ScreenProductDetails(details: allDetails),
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
                    PriceWidget(fontSize: 22, price: allDetails['price']),
                    Consumer<WishListProvider>(
                      builder: (context, value, child) => GestureDetector(
                          onTap: () {
                            String itemName = allDetails['productname']!;
                            value.addToFav(itemName);
                          },
                          child: value.isExist(allDetails['productname']!)
                              ? const Icon(
                                  CupertinoIcons.heart_solid,
                                  color: Colors.red,
                                  size: 28,
                                )
                              : const Icon(
                                  CupertinoIcons.heart,
                                  size: 28,
                                )),
                    )
                  ],
                ),
                CachedNetworkImage(
                  height: 110,
                  width: 120,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                  imageUrl: allDetails['imageList'][0],
                  placeholder: (context, url) => Center(
                    child: Image.asset('assets/images/loadinganimation.gif'),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                constSizedBox10,
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allDetails['productname'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            allDetails['subname'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
