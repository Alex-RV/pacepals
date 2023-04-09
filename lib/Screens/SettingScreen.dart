import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'SignInScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<String> getFullname() async {
    return await SessionManager().get("fullname");
  }

  Future<String> getEmail() async {
    return await SessionManager().get("email");
  }

  Future<String> getUid() async {
    return await SessionManager().get("uid");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Name"),
                    //User name
                    FutureBuilder<String>(
                      future: getFullname(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          return Text(snapshot.data ?? '');
                        }
                      },
                    ),
                  ],
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Email"),
                      //User email
                      FutureBuilder<String>(
                        future: getEmail(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            return Text(snapshot.data ?? '');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    const Text("QR Code"),
                    //User email
                    FutureBuilder<String>(
                      future: getUid(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          return QrImage(
                            data: snapshot.data ?? '',
                            version: QrVersions.auto,
                            size: 200.0,
                          );
                        }
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    await SessionManager().destroy();
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
                )
              ]),
        ));
  }
}
