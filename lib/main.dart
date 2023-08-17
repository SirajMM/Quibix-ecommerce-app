import 'package:e_commerce_store/application/address/address_provider.dart';
import 'package:e_commerce_store/application/cart/cart_provider.dart';
import 'package:e_commerce_store/application/home/home_provider.dart';
import 'package:e_commerce_store/application/login/login_provider.dart';
import 'package:e_commerce_store/application/orders/orders_provider.dart';
import 'package:e_commerce_store/application/product_details/product_details.dart';
import 'package:e_commerce_store/application/sign_up/sign-up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'application/wishlist/wishlist_provider.dart';
import 'presentation/splash/splash_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: false,
      designSize: const Size(1080, 2400),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider<WishListProvider>(
              create: (context) => WishListProvider()),
          ChangeNotifierProvider<LoginProvider>(
              create: (context) => LoginProvider()),
          ChangeNotifierProvider<SignUpProvider>(
            create: (context) => SignUpProvider(),
          ),
          ChangeNotifierProvider<ProductDetailProvider>(
            create: (context) => ProductDetailProvider(),
          ),
          ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider(),
          ),
          ChangeNotifierProvider<AddressProvider>(
            create: (context) => AddressProvider(),
          ),
          ChangeNotifierProvider<OrdersProvider>(
            create: (context) => OrdersProvider(),
          ),
          ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider(),
          ),
        ],
        builder: (context, child) => MaterialApp(
          title: 'Quibix E-Store',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.rajdhaniTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: const ScreenSplash(),
        ),
      ),
    );
  }
}
