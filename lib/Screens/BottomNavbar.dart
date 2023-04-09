import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'HomeScreen.dart';
import 'RunScreen.dart';
import 'SettingScreen.dart';
import 'CommunityScreen.dart';

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
      currentScreen = const CommunityScreen();
    } else if (_currentIndex == 2) {
      currentScreen = const RunScreen();
    } else {
      currentScreen = const SettingScreen();
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
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(icon: Icons.home, text: "home"),
                GButton(icon: Icons.people, text: 'community'),
                GButton(icon: Icons.run_circle, text: 'run'),
                GButton(icon: Icons.settings, text: 'settings')
              ]),
        ),
      ),
    );
  }
}
