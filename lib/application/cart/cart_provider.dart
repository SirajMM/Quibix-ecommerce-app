import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/model/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartProvider extends ChangeNotifier {
  List _ids = [];
  late var _itemCount = 1;

  int get itemCount => _itemCount;
  List get ids => _ids;
  final currentUser = FirebaseAuth.instance.currentUser;
  
  void addToCart(CartModel cartItem) async {
    if (currentUser != null) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.email)
          .collection('cartItems');

      await docRef.get().then((snapshot) async {
        final data = snapshot.docs;

        if (data.isNotEmpty) {
          List<dynamic> existingItem = data.first.get('cartList');
          if (existingItem.contains(cartItem.id)) {
            Fluttertoast.showToast(msg: 'Item already in cart');
          } else {
            existingItem.add(cartItem.id);
            Fluttertoast.showToast(msg: 'Item added to cart');
          }
          await docRef
              .doc(data.first.id)
              .update({'cartList': existingItem, cartItem.id: 1});
        } else {
          await docRef
              .doc()
              .set({
                'cartList': [cartItem.id],
                cartItem.id: 1
              })
              .then((_) => Fluttertoast.showToast(msg: 'Item added to cart'))
              .catchError((error) =>
                  Fluttertoast.showToast(msg: 'Failed to add cart: $error'));
        }
      }).catchError((error) {
        print('Failed to get cart items: $error');
      });
    }
  }

  void deleteCartitem(id) async {
    _ids.remove(id);
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email)
        .collection('cartItems');
    await docRef.get().then((value) {
      final data = value.docs;
      docRef
          .doc(data.first.id)
          .update({'cartList': _ids, id: FieldValue.delete()});
    });
    notifyListeners();
  }

  void getDocId() async {
    final User? user = FirebaseAuth.instance.currentUser;
    CollectionReference cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('cartItems');
    await cartRef.get().then((value) {
      for (var doc in value.docs) {
        _ids = (doc.get('cartList'));
        // print(doc.get('cartList'));
      }
    });
    notifyListeners();
  }

  // getItemCount(id) async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   // var countlist;
  //   CollectionReference cartRef = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.email)
  //       .collection('cartItems');
  //   await cartRef.get().then((value) {
  //     for (var doc in value.docs) {
  //       _itemCount = (doc.get(id));
  //       print(_itemCount);
  //     }
  //   });
  //   // notifyListeners();
  //   // return
  // }

  onItemCountIncrement(id) {
    _itemCount++;
    // getItemCount(id);
    notifyListeners();
  }

  onItemCountDecrement() {
    _itemCount--;
    notifyListeners();
  }
}
