import 'package:e_commerce_store/application/login/login_provider.dart';
import 'package:e_commerce_store/application/product_details/product_details.dart';
import 'package:e_commerce_store/application/sign_up/sign-up.dart';
import 'package:e_commerce_store/widgets/login_or_home/login_or_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'application/wishlist/wishlist_provider.dart';

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
          )
        ],
        builder: (context, child) => MaterialApp(
          title: 'Quibix E-Store',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.blue,
            // iscaffoldBackgroundColor: Color.fromARGB(54, 216, 240, 234),
            textTheme: GoogleFonts.rajdhaniTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: const LoginOrSignIn(),
        ),
      ),
    );
  }
}
