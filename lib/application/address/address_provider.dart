// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/domain/address/model/address_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressProvider extends ChangeNotifier {
 
  int _selectedAddressIndex = -1;
  String selectedAddressId = '';
  int get selectedAddressIndex => _selectedAddressIndex;
 
  final currentUser = FirebaseAuth.instance.currentUser;
  Future<void> addAddress(Address adressModel) async {
    if (currentUser != null) {
      final collectionRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.email)
          .collection('address');

      try {
        final isEmpty = await collectionRef
            .limit(1)
            .get()
            .then((value) => value.docs.isEmpty);
        final isDefaultAddress = isEmpty ? true : false;
        final docRef = collectionRef.doc();
        await docRef.set({
          'name': adressModel.name,
          'pin code': adressModel.pinCode,
          'id': docRef.id,
          'permanent adress': adressModel.permanentAddress,
          'state': adressModel.state,
          'city': adressModel.city,
          'country code': adressModel.countyCode,
          'isDefaultAddress': isDefaultAddress,
          'phoneNumber': adressModel.phoneNumber,
        });
        log('Address added');
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<void> editeAddress(Address adressModel, id) async {
    if (currentUser != null) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.email)
          .collection('address')
          .doc(id);

      try {
        await docRef.update({
          'name': adressModel.name,
          'pin code': adressModel.pinCode,
          'id': docRef.id,
          'permanent adress': adressModel.permanentAddress,
          'state': adressModel.state,
          'city': adressModel.city,
          'country code': adressModel.countyCode,
          'phoneNumber': adressModel.phoneNumber,
        });
        log('Address added');
      } catch (e) {
        log(e.toString());
      }
    }
  }

  void updateSelectedAddress(String selectedAddressId) async {
    this.selectedAddressId = selectedAddressId;
    final CollectionReference addressesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email)
        .collection('address');
    final batch = FirebaseFirestore.instance.batch();

    batch.update(
        addressesCollection.doc(selectedAddressId), {'isDefaultAddress': true});

    final addressSnapshot = await addressesCollection.get();
    for (final doc in addressSnapshot.docs) {
      final addressId = doc.id;
      if (addressId != selectedAddressId) {
        batch.update(
            addressesCollection.doc(addressId), {'isDefaultAddress': false});
      }
    }
    await batch.commit();
    notifyListeners();
  }

  Future<void> getDefaultAddress() async {
    final CollectionReference addressesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email)
        .collection('address');
    final defaultAddressSnapshot = await addressesCollection
        .where('isDefaultAddress', isEqualTo: true)
        .limit(1)
        .get();

    if (defaultAddressSnapshot.docs.isNotEmpty) {
      selectedAddressId = defaultAddressSnapshot.docs[0].id;
    } else {
      selectedAddressId = '';
    }
    notifyListeners();
  }

  Stream getSelectedAddressStream() {
    final CollectionReference addressesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email)
        .collection('address');

    if (selectedAddressId == null) {
      return const Stream.empty();
    }
    return addressesCollection.doc(selectedAddressId).snapshots();
  }

  Future<void> deleteAddress(String id) async {
    final CollectionReference addressRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email)
        .collection('address');

    try {
      await addressRef.doc(id).delete();

      Fluttertoast.showToast(msg: 'Address deleted');

      final querySnapshot = await addressRef.limit(2).get();

      if (querySnapshot.docs.length == 1) {
        final docId = querySnapshot.docs.first.id;
        await addressRef.doc(docId).update({'isDefaultAddress': true});
      }

      getDefaultAddress();
      selectedAddressId = '';
    } catch (e) {
      log(e.toString());
    }
  }

  void setSelectedAddressIndex(int index) {
    _selectedAddressIndex = index;
    notifyListeners();
  }
}
