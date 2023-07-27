import 'package:e_commerce_store/presentation/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/colors/app_color.dart';

class HomeCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeCustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(90.0);
  @override
  Widget build(BuildContext context) {
    var respsize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: respsize.height * 0.05,
            width: respsize.width * 0.8,
            child: Material(
              elevation: 5,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    CupertinoIcons.search_circle_fill,
                    size: respsize.width * 0.09,
                    color: AppConstantsColor.materialThemeColor,
                  ),
                  filled: true,
                  fillColor: AppConstantsColor.lightTextColor,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const ScreenProfile(),
              ),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser!.photoURL ?? ''),
            ),
          ),
        ],
      ),
    );
  }
}
