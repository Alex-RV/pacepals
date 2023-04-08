// ignore: file_names
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Title"),
        ),
        body: Center(
          child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(3),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          child: SizedBox(
            width: 400,
            height: 200,
            child: Column(
              children: <Widget>[
                const Text('Deliver features faster'),
                const Text('Craft beautiful UIs'),
                Container(),
              ],
            ),
          ),
        )));
  }
}
