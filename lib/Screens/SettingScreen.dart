import 'package:flutter/material.dart';
import 'package:pacepals/globals.dart' as globals;
import 'package:qr_flutter/qr_flutter.dart';

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
      backgroundColor: const Color(0xFF191414),
        appBar: AppBar(
          title: const Text("Settings"),
          backgroundColor: const Color(0xFF191414),
          foregroundColor: const Color(0xFF1DB954),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 3.0,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Name: ", style: TextStyle(color: Colors.white, fontSize: 36)),
                      //User name
                      Text(globals.fullname, style: TextStyle(color: Colors.white, fontSize: 36))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 3.0,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Email: ", style: TextStyle(color: Colors.white, fontSize: 36)),
                      //User email
                      Text(globals.email, style: TextStyle(color: Colors.white, fontSize: 36))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 3.0,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text("QR Code:", style: TextStyle(color: Colors.white, fontSize: 36)),
                      //User email
                      Container(margin: EdgeInsets.all(25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [QrImage(
                          data: globals.uid,
                          version: QrVersions.auto,
                          size: 200.0,
                          backgroundColor: Colors.white,
                      ),],),),
                      
                      
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,  
                    children: [ElevatedButton(
                  onPressed: () async {
                    globals.email = "";
                    globals.fullname = "";
                    globals.sid = "";
                    globals.uid = "";
                    globals.isLoggedIn = false;
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                  ),
                  child: const Text("Sign Out"),
                )]),
                )
              ]),
        ));
  }
}
