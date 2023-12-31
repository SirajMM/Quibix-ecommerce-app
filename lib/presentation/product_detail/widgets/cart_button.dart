import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/application/cart/cart_provider.dart';
import 'package:e_commerce_store/application/product_details/product_details.dart';
import 'package:e_commerce_store/domain/cart/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/colors/app_color.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.product,
  });
  final DocumentSnapshot product;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          elevation: MaterialStateProperty.all<double?>(3),
          foregroundColor: MaterialStateProperty.all<Color?>(
              AppConstantsColor.materialThemeColor),
          backgroundColor: MaterialStateProperty.all<Color?>(
              AppConstantsColor.lightTextColor),
          fixedSize: MaterialStateProperty.all(Size(600.w, 120.h)),
        ),
        onPressed: () {
          Provider.of<CartProvider>(context, listen: false).addToCart(CartModel(
              id: product['id'],
              color: Provider.of<ProductDetailProvider>(context, listen: false)
                  .isSelected,
              count: 1,
              price: int.parse(product['price']),
              quantity: int.parse(product['quantity'] ?? 0),
              totalPrice: int.parse(product['price'])));
          Provider.of<CartProvider>(context, listen: false).getDocId();
        },
        icon: const Icon(Icons.shopping_cart),
        label: const Text('Add To Cart'));
  }
}
