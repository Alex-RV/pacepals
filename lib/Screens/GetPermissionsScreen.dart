import 'dart:ui';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:pacepals/globals.dart' as globals;

class GetPermissionsScreen extends StatefulWidget {
  @override
  _GetPermissionsScreenState createState() => _GetPermissionsScreenState();
}

class _GetPermissionsScreenState extends State<GetPermissionsScreen> {
// In your function for transferring for screen if everything is ok, use:

// Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );

  @mustCallSuper
  void mount(Element? parent, Object? newSlot) async {
    print("yo, where do button");
    setLocation();
  }

  _handlePress() async {
    setLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [TextButton(
        onPressed: () {
          _handlePress();
        },
        child: const Text("Try to Get Location"),
      ),],)
    );
  }
}

class UserLocation {
  final double latitude;
  final double longitude;

  UserLocation(this.latitude, this.longitude);
}

void setLocation() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      throw "Location Data Denied";
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      throw "Location Data Denied";
    }
  }

  location.changeSettings(accuracy: LocationAccuracy.balanced);
  locationData = await location.getLocation();

  if (locationData.latitude == null || locationData.longitude == null) {
    throw "Failed to Get Location Data";
  }

  var userLocation =
      UserLocation(locationData.latitude ?? 0, locationData.longitude ?? 0);
  globals.staticLocation = userLocation as List;
}
