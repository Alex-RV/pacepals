// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'HomeScreen.dart';

void main() => runApp(const BottomNavBar());

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  int _currentIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;
    if (_currentIndex == 0) {
      currentScreen = HomeScreen();
    } else if (_currentIndex == 1) {
      currentScreen = HomeScreen();
    } else if (_currentIndex == 2) {
      currentScreen = HomeScreen();
    } else {
      currentScreen = HomeScreen();
    }

    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
              backgroundColor: Colors.black,
              color: Colors.green,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.green.shade700,
              gap: 8,
              onTabChange: (index) {
                print(index);
              },
              padding: EdgeInsets.all(16),
              tabs: const [
                GButton(icon: Icons.home, text: "Home"),
                GButton(icon: Icons.people, text: 'Community'),
                GButton(icon: Icons.run_circle, text: 'Run'),
                GButton(icon: Icons.settings, text: 'Settings')
              ]),
        ),
      ),
    );
  }
}
