import 'package:e_commerce_store/model/functions/auth.dart';
import 'package:e_commerce_store/presentation/login/login_screen.dart';
import 'package:e_commerce_store/presentation/main_page/screen_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginOrSignIn extends StatelessWidget {
  const LoginOrSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            strokeWidth: 2,
          ));
        }
        if (snapshot.hasData) {
          return ScreenMain();
        } else {
          return const ScreenLogin();
        }
      },
    );
  }
}
