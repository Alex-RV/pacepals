import 'dart:ffi';

import 'package:flutter/material.dart';
import 'Screens/SignInScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/BottomNavbar.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  static const primaryColor = Color(0xFF151026);
  bool isLoggedIn = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: primaryColor 
        ),
        home: isLoggedIn == true ? SignInScreen() : const BottomNavBar());
  }
}
