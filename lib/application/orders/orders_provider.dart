import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrdersProvider extends ChangeNotifier {
  final currentUser = FirebaseAuth.instance.currentUser;

  void orderItem() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final CollectionReference cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .collection('cartItems');
      final CollectionReference orderRef =
          FirebaseFirestore.instance.collection('orders');

      try {
        QuerySnapshot cartSnapshot = await cartRef.get();
        List<QueryDocumentSnapshot> cartItems = cartSnapshot.docs;

        if (cartItems.isNotEmpty) {
          DocumentReference newOrderDocRef = await orderRef.add({
            'orderTime': FieldValue.serverTimestamp(),
            'isActive': true,
            'orderStatus': 'Status.order',
            'items': cartItems.map((cartItem) => cartItem.data()).toList(),
          });
          String orderId = newOrderDocRef.id;
          await newOrderDocRef.update({'orderId': orderId});
          for (var cartItem in cartItems) {
            await cartItem.reference.delete();
          }

          Fluttertoast.showToast(msg: 'Order placed successfully!');
        } else {
          Fluttertoast.showToast(
              msg: 'Cart is empty. Add items to cart first.');
        }
      } catch (error) {
        Fluttertoast.showToast(msg: 'Failed to order item: $error');
      }
    }
  }
}
