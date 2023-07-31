import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/presentation/address/address.dart';
import 'package:e_commerce_store/presentation/cart/cart_screen.dart';
import 'package:e_commerce_store/presentation/orders/my_orders.dart';
import 'package:e_commerce_store/presentation/profile/widgets/profile_circleavathar.dart';
import 'package:e_commerce_store/presentation/profile/widgets/profile_sttings_tile.dart';
import 'package:e_commerce_store/presentation/whishlist/whishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'privacy_policy/privacy_policy.dart';
import 'functions/profile_functions.dart';
import 'terms_and_conditions/terms_and_conditions.dart';
import 'widgets/background_design.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  BagroundDesign(),
                  ProfieCircleAvathar(),
                ],
              ),
              Text(
                userEmail,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                userName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              constSizedBox20,
              Padding(
                padding: const EdgeInsets.only(
                  left: 110,
                  right: 110,
                ).r,
                child: Container(
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
                        ProfileSettingsTile(
                          icons: CupertinoIcons.location,
                          text: 'Address',
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ScreenAddAddress(),
                              )),
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
                        ProfileSettingsTile(
                          icons: Icons.privacy_tip_outlined,
                          text: 'Privacy Policy',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicy(),
                                ));
                          },
                        ),
                        constSizedBox10,
                        ProfileSettingsTile(
                          icons: Icons.description_outlined,
                          text: 'Terms And Conditions',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TermsAndConditions(),
                                ));
                          },
                        ),
                        constSizedBox10,
                        ProfileSettingsTile(
                          icons: Icons.logout_outlined,
                          text: 'Log Out',
                          onTap: () {
                            ProfileFunctions().dialogBuilder(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final String userEmail = FirebaseAuth.instance.currentUser!.email!;
final String userName = FirebaseAuth.instance.currentUser!.displayName ?? '';
