import 'package:flutter/material.dart';

class RunScreen extends StatefulWidget {
  const RunScreen({Key? key}) : super(key: key);

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Run"),
      ),
    );
  }
}
