import 'package:allinonestore/auth/sign_in.dart';
import 'package:allinonestore/provider/check_out_provider.dart';
// import 'package:allinonestore/provider/google_signin.dart';
import 'package:allinonestore/provider/product_provider.dart';
import 'package:allinonestore/provider/review_cart_provider.dart';
import 'package:allinonestore/provider/user_provider.dart';

import 'package:allinonestore/provider/wishlist_products_provider.dart';
import 'package:allinonestore/screen/home_screen.dart';
import 'package:allinonestore/screen/search/search.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<CheckOutProvider>(
          create: (context) => CheckOutProvider(),
        ),
        // ChangeNotifierProvider<GoogleSignInProvider>(
        //   create: (context) => GoogleSignInProvider(),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignIn(),
        // HomeScreen(),
      ),
    );
  }
}
