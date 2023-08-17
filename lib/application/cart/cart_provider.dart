import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/model/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartProvider extends ChangeNotifier {
  List _ids = [];
  int totalPrice = 0;
  List<int> itemCounts = [];

  List get ids => _ids;
  final currentUser = FirebaseAuth.instance.currentUser;

  void addToCart(CartModel cartItem) async {
    if (currentUser != null) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.email)
          .collection('cartItems');

      try {
        final snapshot = await docRef.get();
        final data = snapshot.docs;

        if (data.isNotEmpty) {
          List<String> existingItems = data.map((doc) => doc.id).toList();
          if (existingItems.contains(cartItem.id)) {
            Fluttertoast.showToast(msg: 'Item already in cart');
          } else {
            existingItems.add(cartItem.id);
            Fluttertoast.showToast(msg: 'Item added to cart 🛒');
          }
          await docRef.doc(cartItem.id).set({
            'cartList': cartItem.id,
            'price': cartItem.price,
            'quantity': cartItem.quantity,
            'totalPrice': cartItem.totalPrice,
            'color': cartItem.color,
            'count': cartItem.count
          });
        } else {
          await docRef.doc(cartItem.id).set({
            'cartList': cartItem.id,
            'price': cartItem.price,
            'quantity': cartItem.quantity,
            'totalPrice': cartItem.totalPrice,
            'color': cartItem.color,
            'count': cartItem.count
          });
          Fluttertoast.showToast(msg: 'Item added to cart 🛒');
        }
      } catch (error) {
        Fluttertoast.showToast(msg: 'Failed to get cart items: $error');
      }
    }
    getItemCounts();
  }

  void deleteCartitem(id) async {
    _ids.remove(id);
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email)
        .collection('cartItems');
    await docRef.get().then((value) {
      docRef.doc(id).delete();
    });

    getItemCounts();
    getTotalPrice();
    notifyListeners();
  }

  void getDocId() async {
    final User? user = FirebaseAuth.instance.currentUser;
    CollectionReference cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('cartItems');
    await cartRef.get().then((value) {
      _ids = value.docs.map((doc) => doc.id).toList();
    });

    notifyListeners();
  }

  Future<void> getItemCounts() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        CollectionReference cartRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .collection('cartItems');

        QuerySnapshot querySnapshot = await cartRef.get();
        itemCounts.clear();
        for (var doc in querySnapshot.docs) {
          itemCounts.add(doc['count']);
        }
        debugPrint(itemCounts.toString());
      } catch (error) {
        debugPrint('Error getting cart items: $error');
      }
    }
  }

  Future<int> getTotalPrice() async {
    int totalPrice = 0;
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .collection('cartItems')
            .get();

        for (var doc in querySnapshot.docs) {
          int? docTotalPrice = doc.get('totalPrice') as int?;
          if (docTotalPrice != null) {
            totalPrice += docTotalPrice;
          }
        }

        debugPrint(totalPrice.toString());
        return totalPrice;
      } catch (error) {
        debugPrint('Error getting total price: $error');
        return 0;
      }
    }

    return 0;
  }

  void onItemCountIncrement(index, id) async {
    final CollectionReference cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email)
        .collection('cartItems');
    final docRef = await cartRef.doc(id).get();
    int price = docRef.get('price');
    itemCounts[index] += 1;
    cartRef.doc(id).update(
        {'count': itemCounts[index], 'totalPrice': itemCounts[index] * price});
    debugPrint(itemCounts[index].toString());
    notifyListeners();
  }

  Future<String> getCartDetails(String id) async {
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email)
        .collection('cartItems');
    final cartDoc = cartRef.doc(id);
    final cartData = await cartDoc.get();
    return cartData.data()!['color'];
  }

  void onItemCountDecrement(index, id) async {
    final CollectionReference cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email)
        .collection('cartItems');
    final docRef = await cartRef.doc(id).get();
    int price = docRef.get('price');
    if (itemCounts[index] > 1) {
      itemCounts[index] -= 1;
    }

    cartRef.doc(id).update(
        {'count': itemCounts[index], 'totalPrice': itemCounts[index] * price});
    notifyListeners();
  }
}
