import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrdersProvider extends ChangeNotifier {
  List myFields = [];
  final User? currentUser = FirebaseAuth.instance.currentUser;

  void orderItem() async {
    if (currentUser != null) {
      final CollectionReference cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.email)
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

  Future<void> cancelOrder(String id) async {
    final CollectionReference orderRef =
        FirebaseFirestore.instance.collection('orders');

    try {
      final querySnapshot = await orderRef.get();
      final documents = querySnapshot.docs;

      for (var document in documents) {
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>;
        if (data.isNotEmpty) {
          List<dynamic> items = data['items'] ?? [];

          for (var item in items) {
            final myField = item['cartList'];

            if (myField == id) {
              await document.reference.delete();
              Fluttertoast.showToast(msg: 'Order has been canceled.');
              return;
            }
          }
        }
      }

      Fluttertoast.showToast(msg: 'Order with ID $id was not found.');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to cancel order: $e');
    }
    getOrderIds();
    notifyListeners();
  }

  getOrderIds() async {
    final collectionRef = FirebaseFirestore.instance.collection('orders');
    final querySnapshot = await collectionRef.get();
    final documents = querySnapshot.docs;
    myFields.clear();
    for (var document in documents) {
      // Assuming 'items' is a list of maps
      List<dynamic> items = document.data()['items'];
      for (var item in items) {
        final myField = item['cartList'];
        myFields.add(myField);
      }
    }
    notifyListeners();
  }
}
