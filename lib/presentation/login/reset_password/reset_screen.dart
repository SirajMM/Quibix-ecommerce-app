import 'dart:developer';
import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:e_commerce_store/core/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var width = size.width;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  'Reset Password',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      letterSpacing: .5,
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                constSizedBox10,
                Text(
                  'Please Enter Your Email To Reset',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      letterSpacing: .5,
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                constSizedBox20,
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                      return "Enter Valid Email";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Enter Email',
                  ),
                ),
                constSizedBox20,
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 3, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      backgroundColor: AppConstantsColor.materialThemeColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        log('validation success');
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: emailController.text)
                            .then((value) {
                          log('Reset Success');
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.info(
                              message: "Check Your Email",
                            ),
                          );
                          emailController.clear();
                          Navigator.pop(context);
                        }).onError((error, stackTrace) {
                          Navigator.pop(context);
                          showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.info(
                                message: "Error: ${error.toString()}",
                              ));
                          log('Error: ${error.toString()}');
                        });
                      }
                    },
                    child: Text(
                      'Submit',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
