// ignore_for_file: file_names

import 'package:e_commerce_store/application/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartFunctions {
  static Future<void> dialogBuilder(BuildContext context, id) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete ?'),
          content: const Text(
            'Are you sure want to delete the item.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .deleteCartitem(id);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
