import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pacepals/Screens/CommunityScreen.dart';
import 'package:pacepals/Screens/RunScreen.dart';
import 'package:pacepals/Screens/SettingScreen.dart';
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
        color: const Color(0xFF191414),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: const Color(0xFF191414),
            color: const Color(0xFF1DB954),
            activeColor: Colors.white,
            tabBackgroundColor: Colors.green.shade700,
            gap: 8,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
                print(_currentIndex);
              });
            },
            padding: EdgeInsets.all(16),
            tabs: const [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.people, text: 'Community'),
              GButton(icon: Icons.run_circle, text: 'Run'),
              GButton(icon: Icons.settings, text: 'Settings')
            ],
          ),
        ),
      ),
    );
  }
}
