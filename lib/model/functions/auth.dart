import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../widgets/login_or_home/login_or_home.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password,required context}) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginOrSignIn(),
              ),
            ));
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password, context}) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginOrSignIn(),
              ),
            ));
  }

  Future<void> signOut1() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // FirebaseAuth.instance.signInWithCredential(credential);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    log('User signed in with Google: ${userCredential.user?.displayName}');
  }
}
