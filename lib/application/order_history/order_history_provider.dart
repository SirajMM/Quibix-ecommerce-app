import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderHistoryProvider extends ChangeNotifier {
  List<String> myFields = [];
  getoderids() async {
    final collectionRef = FirebaseFirestore.instance.collection('orders');
    final querySnapshot = await collectionRef.get();
    final documents = querySnapshot.docs;

    for (var document in documents) {
      final myField = document.data()['cartList'];
      myFields.add(myField);
    }
  }
}
