import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrdersProvider extends ChangeNotifier {
  List myFields = [];
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? data;
  void orderItemAndDeletFromCart() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userRef = firestore.collection('users');
    CollectionReference cartRef =
        userRef.doc(currentUser!.email).collection('cartItems');
    Query<Map<String, dynamic>> addressDoc = userRef
        .doc(currentUser!.email)
        .collection('address')
        .where('isDefaultAddress', isEqualTo: true);
    QuerySnapshot<Map<String, dynamic>> addressData = await addressDoc.get();
    String addressId = addressData.docs.first.id;

    CollectionReference orederRef = firestore.collection('orders');
    QuerySnapshot cartSnapshot = await cartRef.get();
    List<QueryDocumentSnapshot> cartDoc = cartSnapshot.docs;
    WriteBatch batch = firestore.batch();
    for (var doc in cartDoc) {
      Map<String, dynamic> cartItemData = doc.data() as Map<String, dynamic>;
      DocumentReference orderDocRef = orederRef.doc();
      cartItemData['orderDate'] = Timestamp.now();
      cartItemData['status'] = 'Placed';
      cartItemData['isActive'] = true;
      cartItemData['orderid'] = orderDocRef.id;
      cartItemData['addressId'] = addressId;
      cartItemData['userEmail'] = currentUser!.email;
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
      if (document.data()['isActive'] == true) {
        final item = document.data()['cartList'];
        myFields.add(item);
      }
    }

    notifyListeners();
  }

  Future<void> getOrderData(int index) async {
    try {
      final CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('orders');
      final QuerySnapshot querySnapshot = await collectionRef.get();
      if (querySnapshot.docs.isNotEmpty && index < querySnapshot.docs.length) {
        final DocumentSnapshot docSnapshot = querySnapshot.docs[index];
        data = docSnapshot.data() as Map<String, dynamic>;
      } else {
        log("Invalid index or empty collection.");
      }
    } catch (e) {
      log("Error getting order data: $e");
    }
  }

  Stream<DocumentSnapshot> getProductData(String id) {
    final orderRef = FirebaseFirestore.instance.collection('products');
    final orderDoc = orderRef.doc(id);
    return orderDoc.snapshots();
  }
}
