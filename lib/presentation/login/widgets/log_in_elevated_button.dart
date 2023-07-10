// ignore_for_file: must_be_immutable

import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:flutter/material.dart';

class LogInElevatodButton extends StatelessWidget {
  const LogInElevatodButton(
      {super.key, required this.text, required this.onTap});
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: AppConstantsColor.materialThemeColor,
          minimumSize: const Size.fromHeight(50), 
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }
}
