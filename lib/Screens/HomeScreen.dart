import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  Future<Position> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  late GoogleMapController mapController;
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF191414),
        foregroundColor: const Color(0xFF1DB954),
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.730068, -122.415336),
              zoom: 10,
            ),
            myLocationEnabled: true,
            markers: _markers,
          ),
        ],
      ),
    );
  }
}

    // return Scaffold(
    //   backgroundColor: const Color(0xFF191414),
    //   appBar: AppBar(
    //     backgroundColor: const Color(0xFF191414),
    //     foregroundColor: const Color(0xFF1DB954),
    //     title: const Text("Home"),
    //     centerTitle: true,
    //   ),
    //   body: Center(
    //       child: Container(
    //     margin: const EdgeInsets.all(25),
    //     padding: const EdgeInsets.all(3),
    //     decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
    //     child: SizedBox(
    //       width: 300,
    //       height: 300,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           const Text(
    //             'Recommended',
    //             style: TextStyle(color: Colors.white),
    //           ),
    //           // Image.asset(
    //           //   'assets/pacepalsBackground.png',
    //           //   height: 250,
    //           //   width: 500,
    //           // ),
    //           CarouselSlider(
    //             options: CarouselOptions(height: 250, viewportFraction: 1),
    //             items: images.map((i) {
    //               return Builder(
    //                 builder: (BuildContext context) {
    //                   return Container(
    //                     width: MediaQuery.of(context).size.width,
    //                     margin: const EdgeInsets.symmetric(horizontal: 5.0),
    //                     decoration: BoxDecoration(
    //                         image: DecorationImage(
    //                             image: NetworkImage(i), fit: BoxFit.cover),
    //                         color: Colors.amber),
    //                   );
    //                 },
    //               );
    //             }).toList(),
    //           ),
    //           const Text(
    //             'guy running',
    //             textAlign: TextAlign.center,
    //             style: TextStyle(color: Colors.white),
    //           ),
    //         ],
    //       ),
    //     ),
    //   )),
    // );