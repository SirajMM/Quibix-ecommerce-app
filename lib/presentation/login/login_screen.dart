// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously
import 'package:e_commerce_store/application/login/login_provider.dart';
import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/infrastructure/authentication/auth.dart';
import 'package:e_commerce_store/presentation/SignUp/sign_up_screen.dart';
import 'package:e_commerce_store/presentation/login/widgets/log_in_elevated_button.dart';
import 'package:e_commerce_store/presentation/login/widgets/text_field.dart';
import 'package:e_commerce_store/presentation/widgets/login_or_home/login_or_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/navigate_signin_and_signup.dart';
import 'reset_password/reset_screen.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  @override
  Widget build(BuildContext context) {
    // User? user = FirebaseAuth.instance.currentUser;
    final respSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _key1,
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
                    'Sign In',
                    style: TextStyle(
                        color: AppConstantsColor.lightTextColor,
                        fontSize: 50,
                        fontWeight: FontWeight.w600),
                  ),
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
                      comtroller: _emailController,
                      validator: validateEmail),
                  SizedBox(
                    height: respSize.height * 0.02,
                  ),
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
                          Provider.of<LoginProvider>(context).obscureText,
                      eyeIcon: Consumer<LoginProvider>(
                        builder: (context, value, child) => GestureDetector(
                            onTap: () {
                              value.changeObscureText();
                            },
                            child: Icon((value.obscureText)
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash)),
                      ),
                      comtroller: _paswordController,
                      validator: validatePassword),
                  constSizedBox10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetScreen(),
                            )),
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                              color: AppConstantsColor.lightTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w200),
                        ),
                      )
                    ],
                  ),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: respSize.height * 0.06,
                  ),
                  LogInElevatodButton(
                    onTap: () async {
                      if (_key1.currentState!.validate()) {
                        await Auth().signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _paswordController.text,
                            context: context);
                      }
                      _emailController.clear();
                      passwordController.clear();
                    },
                    text: 'Log In',
                  ),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'or',
                          style: TextStyle(
                              color: AppConstantsColor.lightTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
                        ),
                      ]),
                  LogInElevatodButton(
                    onTap: () async {
                      await Auth()
                          .signInWithGoogle()
                          .then((value) => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginOrSignIn(),
                              ),
                              (route) => false));
                    },
                    text: 'Continue with Google',
                  ),
                  constSizedBox10,
                  SwitchSingInAndSignUp(
                    mainText: 'Don\'t have an Account?',
                    subText: ' Create',
                    ontap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScreenSignUp(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail!.isEmpty || formEmail == null) {
    return 'E-mail address is required.';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regexp = RegExp(pattern);
  if (!regexp.hasMatch(formEmail)) return 'Invalid E-mail Address';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword!.isEmpty || formPassword == null) {
    return 'password is required.';
  }

  return null;
}

String errorMessage = '';
final TextEditingController _emailController = TextEditingController();

final TextEditingController _paswordController = TextEditingController();
final GlobalKey<FormState> _key1 = GlobalKey<FormState>();
