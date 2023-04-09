// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  Future<String> getFullname() async {
    return await SessionManager().get("fullname");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder<String>(
          future: getFullname(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return Text(snapshot.data ?? '');
            }
          },
        ),
      ),
      body: Center(
          child: Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: SizedBox(
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text('Recommended'),
              Image.asset(
                'assets/pacepalsBackground.png',
                height: 250,
                width: 500,
              ),
              const Text(
                'guy running',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      )),
    );
  }
}
