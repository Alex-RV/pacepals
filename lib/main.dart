import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter/material.dart';
import 'Screens/SignInScreen.dart';
import 'Screens/BottomNavbar.dart';

Future<bool> getSid() async {
  if (await SessionManager().get("sid") != null) {
    return true;
  }
  return false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const primaryColor = Color(0xFF151026);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getSid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
              home: Scaffold(body: CircularProgressIndicator()));
        } else {
          bool isLoggedIn = true;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(primaryColor: primaryColor),
            home: isLoggedIn ? const BottomNavBar() : SignInScreen(),
          );
        }
      },
    );
  }
}

void main() {
  runApp(MyApp());
}
