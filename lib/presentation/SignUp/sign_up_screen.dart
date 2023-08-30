// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:e_commerce_store/infrastructure/authentication/auth.dart';
import 'package:e_commerce_store/presentation/login/reset_password/reset_screen.dart';
import 'package:e_commerce_store/presentation/widgets/navigate_signin_and_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/sign_up/sign-up.dart';
import '../../core/colors/app_color.dart';
import '../../core/constants.dart';
import '../login/login_screen.dart';
import '../login/widgets/log_in_elevated_button.dart';
import '../login/widgets/text_field.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController paswordController = TextEditingController();
final TextEditingController confirmPaswordController = TextEditingController();
TextEditingController nameController = TextEditingController();
String errorMessage = '';

class _ScreenSignUpState extends State<ScreenSignUp> {
  @override
  Widget build(BuildContext context) {
    final respSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _key,
        child: Container(
          height: respSize.height,
          width: respSize.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppConstantsColor.materialThemeColor2,
                AppConstantsColor.materialThemeColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(
                    height: respSize.height * 0.15,
                  ),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: AppConstantsColor.lightTextColor,
                        fontSize: 50,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: respSize.height * 0.02,
                  ),
                  const Text(
                    'Name',
                    style: TextStyle(
                        color: AppConstantsColor.lightTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  constSizedBox10,
                  CustomTextField(
                      obscureText: false, comtroller: nameController),
                  SizedBox(
                    height: respSize.height * 0.02,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(
                        color: AppConstantsColor.lightTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  constSizedBox10,
                  CustomTextField(
                      obscureText: false,
                      comtroller: emailController,
                      validator: validateEmail),
                  constSizedBox10,
                  const Text(
                    'Password',
                    style: TextStyle(
                        color: AppConstantsColor.lightTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  constSizedBox10,
                  CustomTextField(
                      obscureText:
                          Provider.of<SignUpProvider>(context).obscureText,
                      eyeIcon: Consumer<SignUpProvider>(
                        builder: (context, value, child) => GestureDetector(
                            onDoubleTap: () => value.changeObscureText(),
                            child: Icon(
                              (value.obscureText)
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash,
                              size: 30,
                            )),
                      ),
                      comtroller: paswordController,
                      validator: validatePassword),
                  constSizedBox10,
                  const Text(
                    'Confirm Password',
                    style: TextStyle(
                        color: AppConstantsColor.lightTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  constSizedBox10,
                  CustomTextField(
                      obscureText:
                          Provider.of<SignUpProvider>(context).conFirmText,
                      eyeIcon: Consumer<SignUpProvider>(
                        builder: (context, value, child) => GestureDetector(
                          onTap: () {
                            value.confirmChangeObscureText();
                          },
                          child: Icon(
                            (value.conFirmText)
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            size: 30,
                          ),
                        ),
                      ),
                      comtroller: confirmPaswordController,
                      validator: validateConfirmPassword),
                  constSizedBox10,
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: respSize.height * 0.04,
                  ),
                  LogInElevatodButton(
                    onTap: () {
                      if (_key.currentState!.validate()) {
                        createUserWithEmailAndpassword();
                      }

                      emailController.clear();
                      passwordController.clear();
                      confirmPaswordController.clear();
                      nameController.clear();
                    },
                    text: 'Sign Up',
                  ),
                  constSizedBox10,
                  SwitchSingInAndSignUp(
                    mainText: 'Already a user?',
                    subText: ' SignIn',
                    ontap: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  createUserWithEmailAndpassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: emailController.text,
          password: paswordController.text,
          context: context);
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.message!;
        });
      }

      log(e.toString());
    }
  }
}

String? validateConfirmPassword(confirmPaswordController) {
  if (paswordController.text != confirmPaswordController) {
    return 'Password deos not match!';
  }

  return null;
}

final GlobalKey<FormState> _key = GlobalKey<FormState>();
