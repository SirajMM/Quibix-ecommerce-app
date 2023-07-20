import 'package:animations/animations.dart';
import 'package:e_commerce_store/presentation/main_page/widgets/bottomnav.dart';
import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import '../orders/my_orders.dart';
import '../whishlist/whishlist.dart';

class ScreenMain extends StatelessWidget {
  ScreenMain({super.key});
  final List<Widget> _screens = [
    const ScreenHome(),
    const ScreenWhishList(),
    const ScreenCart(),
    const ScreenOrders(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, index, child) => PageTransitionSwitcher(
            duration: const Duration(milliseconds: 700),
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                FadeThroughTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    child: child),
            child: _screens[index]),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
