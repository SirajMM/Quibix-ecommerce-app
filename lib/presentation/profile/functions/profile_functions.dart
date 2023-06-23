import 'package:e_commerce_store/model/functions/auth.dart';
import 'package:e_commerce_store/presentation/login/login_screen.dart';
import 'package:flutter/material.dart';

class ProfileFunctions {
  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out ?'),
          content: const Text(
            'Are you sure want to log out.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Log out',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Auth().signOut1();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenLogin(),
                    ),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
