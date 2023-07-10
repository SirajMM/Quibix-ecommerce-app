import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.comtroller,
      this.validator,
      this.eyeIcon,
      this.obscureText});
  final TextEditingController comtroller;
  final Widget? eyeIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: comtroller,
      obscureText:obscureText !,
      decoration: InputDecoration(
        suffixIcon: eyeIcon,
        filled: true,
        fillColor: Colors.white.withOpacity(.7),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
