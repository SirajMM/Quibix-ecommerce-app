import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class HomeProvider extends ChangeNotifier {
  File? imageFile;
  String? downloadUrl;
  bool picking = false;
  final user = FirebaseAuth.instance.currentUser!;
  Future<void> uploadImageToFirebase(File imageFile) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      Reference storageReference = storage.ref().child('images/$imageName');
      UploadTask uploadTask = storageReference.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask;

      downloadUrl = await taskSnapshot.ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .update({'profilePhoto': downloadUrl});

      picking = false;
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error uploading image: $e');
    }
  }

  Future<void> pickImage() async {
    picking = true;
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage;

    try {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed pick image : $e');
    }
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      uploadImageToFirebase(imageFile!);
      notifyListeners();
    }
  }

  getProfileImage() async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(user.email);
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null && data.containsKey('products')) {
        downloadUrl = data['profilePhoto'];
      }
    }

    notifyListeners();
  }

  ImageProvider profileImage() {
    if (downloadUrl == null && user.photoURL == null) {
      return const AssetImage('assets/images/defaultDp.jpg');
    }
    if (downloadUrl == null && user.photoURL != null) {
      return NetworkImage(user.photoURL!);
    }
    if (downloadUrl != null) {
      return NetworkImage(downloadUrl!);
    }
    return const AssetImage('assets/images/defaultDp.jpg');
  }


}
