import 'dart:ffi';

import 'package:flutter/material.dart';
import 'Screens/SignInScreen.dart';
import 'Screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  bool isLoggedIn = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: isLoggedIn == false ? SignInScreen() : const HomeScreen());
        
  }
}
