// ignore_for_file: unnecessary_null_comparison
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/wishlist_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WishListProvider extends ChangeNotifier {
  List<dynamic> existingProducts = [];
  // bool there = false;

  Future<bool> existInWishlist(String id) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');
      final DocumentReference userDoc = userCollection.doc(currentUser.email);

      final DocumentSnapshot userSnapshot = await userDoc.get();
      if (userSnapshot.exists||userSnapshot!=null) {
        existingProducts = List.from(userSnapshot.get('products'));
      }

      log(existingProducts.toString());
      return existingProducts.contains(id);
    }
    return false;
  }

  Future<void> addToWishlist(WishListModel products) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(currentUser.email);

      final snapshot = await docRef.get();

      if (snapshot.exists) {
        final data = snapshot.data();

        if (data != null && data.containsKey('products')) {
          List<dynamic> existingProducts = List<dynamic>.from(data['products']);

          if (existingProducts.contains(products.id)) {
            existingProducts.remove(products.id);
            Fluttertoast.showToast(msg: 'Removed from whishlist');
          } else {
            existingProducts.add(products.id);
            Fluttertoast.showToast(msg: 'Added to wishlist ❤️');
          }

          await docRef.update({'products': existingProducts});
        } else {
          await docRef.update({
            'products': [products.id]
          });
        }
      } else {
        await docRef.set({
          'products': [products.id]
        });
      }
    }
    notifyListeners();
  }

  retreveWishListItem() async {
    final user = FirebaseAuth.instance.currentUser!.email;
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    final userDoc = await userCollection.doc(user).get();

    return userDoc.get('products');
  }

  Future<List<String>> getdocIds(List<String> ids, wishlistRefe) async {
    ids.clear();
    final querySnapshot = await wishlistRefe.get();
    for (var doc in querySnapshot.data()!['products']) {
      ids.add(doc);
    }

    return ids;
  }
}
