import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrdersProvider extends ChangeNotifier {
  List myFields = [];
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // void orderItem() async {
  //   if (currentUser != null) {
  //     final CollectionReference cartRef = FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(currentUser!.email)
  //         .collection('cartItems');
  //     final CollectionReference orderRef =
  //         FirebaseFirestore.instance.collection('orders');

  //     try {
  //       QuerySnapshot cartSnapshot = await cartRef.get();
  //       List<QueryDocumentSnapshot> cartItems = cartSnapshot.docs;

  //       if (cartItems.isNotEmpty) {
  //         DocumentReference newOrderDocRef = await orderRef.add({
  //           'orderTime': FieldValue.serverTimestamp(),
  //           'isActive': true,
  //           'orderStatus': 'Status.order',
  //           'items': cartItems.map((cartItem) => cartItem.data()).toList(),
  //         });
  //         String orderId = newOrderDocRef.id;
  //         await newOrderDocRef.update({'orderId': orderId});
  //         for (var cartItem in cartItems) {
  //           await cartItem.reference.delete();
  //         }

  //         Fluttertoast.showToast(msg: 'Order placed successfully!');
  //       } else {
  //         Fluttertoast.showToast(
  //             msg: 'Cart is empty. Add items to cart first.');
  //       }
  //     } catch (error) {
  //       Fluttertoast.showToast(msg: 'Failed to order item: $error');
  //     }
  //   }
  // }
  void orderItemAndDeletFromCart() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference cartRef = firestore
        .collection('users')
        .doc(currentUser!.email)
        .collection('cartItems');
    CollectionReference orederRef = firestore.collection('orders');
    QuerySnapshot cartSnapshot = await cartRef.get();
    List<QueryDocumentSnapshot> cartDoc = cartSnapshot.docs;
    WriteBatch batch = firestore.batch();
    for (var doc in cartDoc) {
      Map<String, dynamic> cartItemData = doc.data() as Map<String, dynamic>;
      DocumentReference orderDocRef = orederRef.doc();
      cartItemData['orderDate'] = Timestamp.now();
      cartItemData['status'] = 'Pending';
      cartItemData['isActive'] = true;
      cartItemData['orderid'] = orderDocRef.id;
      batch.set(orderDocRef, cartItemData);
      batch.delete(doc.reference);
    }
    try {
      await batch.commit();
      log('Order Success');
    } catch (e) {
      log('Error ordering items: $e');
    }
  }

  Future<void> cancelOrder(
    String id,
  ) async {
    final CollectionReference orderRef =
        FirebaseFirestore.instance.collection('orders');

    try {
      final querySnapshot = await orderRef.get();
      final documents = querySnapshot.docs;

      for (var document in documents) {
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>;
        if (data.isNotEmpty) {
          final item = data['cartList'] ?? [];

          if (item == id) {
            myFields.remove(id);
            await document.reference.delete();
            Fluttertoast.showToast(msg: 'Order has been canceled.');
            notifyListeners();
            return;
          }
        }
      }

      Fluttertoast.showToast(msg: 'Order with ID $id was not found.');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to cancel order: $e');
    }
  }

  getOrderIds() async {
    final collectionRef = FirebaseFirestore.instance.collection('orders');
    final querySnapshot = await collectionRef.get();
    myFields.clear();
    for (var document in querySnapshot.docs) {
      final item = document.data()['cartList'];
      myFields.add(item);
    }

    notifyListeners();
  }
}
