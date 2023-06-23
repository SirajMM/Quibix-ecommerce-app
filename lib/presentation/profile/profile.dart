import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/presentation/cart/cart.dart';
import 'package:e_commerce_store/presentation/orders/my_orders.dart';
import 'package:e_commerce_store/presentation/profile/widgets/profile_circleavathar.dart';
import 'package:e_commerce_store/presentation/profile/widgets/profile_sttings_tile.dart';
import 'package:e_commerce_store/presentation/whishlist/whishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'functions/profile_functions.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const ProfieCircleAvathar(),
                constSizedBox10,
                const Text(
                  'Username',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Text(
                  'user123@gmail.com',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                constSizedBox20,
                Container(
                  height: 1200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppConstantsColor.materialThemeColor.withOpacity(.3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40).r,
                    child: Column(
                      children: [
                        constSizedBox20,
                        ProfileSettingsTile(
                          icons: Icons.shopping_bag,
                          text: 'My Orders',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ScreenOrders(),
                                ));
                          },
                        ),
                        constSizedBox10,
                        const ProfileSettingsTile(
                          icons: CupertinoIcons.location,
                          text: 'Address',
                        ),
                        constSizedBox10,
                        ProfileSettingsTile(
                          icons: CupertinoIcons.heart,
                          text: 'Whishlist',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ScreenWhishList(),
                                ));
                          },
                        ),
                        constSizedBox10,
                        ProfileSettingsTile(
                          icons: CupertinoIcons.cart,
                          text: 'Cart',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ScreenCart(),
                                ));
                          },
                        ),
                        constSizedBox10,
                        const ProfileSettingsTile(
                          icons: Icons.privacy_tip_outlined,
                          text: 'Privacy Policy',
                        ),
                        constSizedBox10,
                        const ProfileSettingsTile(
                          icons: Icons.description_outlined,
                          text: 'Terms And Conditions',
                        ),
                        constSizedBox10,
                        ProfileSettingsTile(
                          icons: Icons.logout_outlined,
                          text: 'Log Out',
                          onTap: () {
                            ProfileFunctions dialoge = ProfileFunctions();
                            dialoge.dialogBuilder(context);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
