// ignore: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Widgets/StaticMaps.dart';
import 'package:pacepals/globals.dart' as globals;

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  

  List<String> images = [
    'assets/pacepalsBackground.png',
    'assets/runningIcon.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.green,
        title: const Text("Home"),
        centerTitle: true,
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
              ),
            ],
          ),
        ),
      )),
    );
  }
}
