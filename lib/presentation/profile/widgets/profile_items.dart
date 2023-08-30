import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/colors/app_color.dart';
import '../../../core/constants.dart';
import '../../address/address.dart';
import '../../cart/cart_screen.dart';
import '../../orders/my_orders.dart';
import '../../whishlist/whishlist.dart';
import '../functions/profile_functions.dart';
import '../privacy_policy/privacy_policy.dart';
import '../terms_and_conditions/terms_and_conditions.dart';
import 'profile_sttings_tile.dart';

class ProfileItems extends StatelessWidget {
  const ProfileItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 110,
        right: 110,
      ).r,
      child: Material(
        type: MaterialType.canvas,
        borderRadius: BorderRadius.circular(15),
        elevation: 5,
        child: Container(
          height: 1200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:
                AppConstantsColor.materialThemeColor.withOpacity(.3),
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
                        builder: (context) =>
                            const ScreenAddAddress(),
                      )),
                ),
                constSizedBox10,
                ProfileSettingsTile(
                  icons: CupertinoIcons.heart,
                  text: 'Wishlist',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ScreenWhishList(),
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
                  color: Colors.red,
                  onTap: () {
                    ProfileFunctions().dialogBuilder(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}