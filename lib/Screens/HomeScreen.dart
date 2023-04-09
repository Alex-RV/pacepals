// ignore: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  Future<String> getFullname() async {
    return await SessionManager().get("fullname");
  }

  List<String> images = [
    'assets/pacepalsBackground.png',
    'assets/runningIcon.png'
  ];

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
              // Image.asset(
              //   'assets/pacepalsBackground.png',
              //   height: 250,
              //   width: 500,
              // ),
              CarouselSlider(
                options: CarouselOptions(height: 250),
                items: images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                  );
                }).toList(),
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
