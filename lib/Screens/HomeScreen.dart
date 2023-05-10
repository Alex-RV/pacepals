import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
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

    var url = Uri.https('pacepals-961.shuttleapp.rs', '/api/sch/suggest');
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "access-control-allow-origin": "*",
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      'Access-Control-Allow-Methods': '*',
    };
    var response = await http.post(url,
        body: jsonEncode({
          "location": {
            "latitude": position.latitude,
            "longitude": position.longitude,
          }
        }),
        headers: headers);
    var data = jsonDecode(response.body);
    print(response.body);
    data["nearby"][0]["statusCode"];
    return data;
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
          // Positioned(
          //   top: 16,
          //   right: 16,
          //   child: TextButton(
          //     onPressed: () async {
          //       try {
          //         Position position = await _getCurrentLocation();
          //         print(position);
          //         // Do something with the position and nearby places data
          //       } catch (e) {
          //         print('Error getting current location and nearby places: $e');
          //       }
          //     },
          //     child: Icon(Icons.location_searching),
          //   ),
          // ),
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
