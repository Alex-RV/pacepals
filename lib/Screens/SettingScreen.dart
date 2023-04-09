import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'SignInScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Container(child: ElevatedButton(
  onPressed: () async {
    await SessionManager().remove("sid");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (Route<dynamic> route) => false,
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    textStyle: TextStyle(fontSize: 20),
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  ),
  child: Text("Sign Out"),
)
)]),
    );
  }
}
