import 'dart:ui';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Text('GetPermissions Screen'));
  }
}
