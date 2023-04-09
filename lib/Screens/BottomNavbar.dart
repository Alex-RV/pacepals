import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'HomeScreen.dart';

void main() => runApp(const BottomNavBar());

class BottomNavBar extends StatefulWidget{
  const BottomNavBar({Key? key}) : super (key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBar();
}


class _BottomNavBar extends State<BottomNavBar>{
  @override:
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: GNav(
      tabs: [
        GButton(icon: Icons.home),
        GButton(icon: Icons.people),
        GButton(icon: Icons.run_circle),
        GButton(icon: Icons.settings)
      ]
      ), 
    );
  }
}
