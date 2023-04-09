import 'package:flutter/material.dart';
import 'Screens/SignInScreen.dart';
import 'Screens/BottomNavbar.dart';
import 'globals.dart' as globals;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const primaryColor = Color(0xFF151026);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pace Pals',
            theme: ThemeData(primaryColor: primaryColor),
            home: globals.isLoggedIn ? const BottomNavBar() : SignInScreen(),
          );
        }
}

void main() {
  runApp(MyApp());
}
