// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_paradise/Commons/splash_page.dart';
import 'package:pet_paradise/Providers/cart_provider.dart';
import 'package:pet_paradise/petPanda_Module/cart.dart';
import 'package:pet_paradise/utils/strings.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyStrings.APP_TITTLE,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      // theme: ThemeData(
      //   primaryColor: Colors.deepOrange.shade500,
      //   colorScheme: ColorScheme.fromSwatch()
      //       .copyWith(secondary: Colors.lightBlue.shade900),
      //   fontFamily: 'Loto',
      // ),
      home: SplashPage(),
      routes: {
        '/cart': (context) => Cart(),
      },
      // home: Test(),
    );
  }
}
