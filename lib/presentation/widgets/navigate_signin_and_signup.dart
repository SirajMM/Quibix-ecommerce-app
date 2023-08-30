import 'package:flutter/material.dart';
import '../../core/colors/app_color.dart';

class SwitchSingInAndSignUp extends StatelessWidget {
  const SwitchSingInAndSignUp({
    super.key,
    required this.mainText,
    required this.subText,
    required this.ontap,
  });
  final String mainText;
  final String subText;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => ontap(),
          child: Row(
            children: [
              Text(
                mainText,
                style: const TextStyle(
                    color: AppConstantsColor.lightTextColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                subText,
                style: const TextStyle(
                    color: Color.fromARGB(255, 55, 35, 99),
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        )
      ],
    );
  }
}