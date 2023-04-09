import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget getTextWidgets(List<String> strings) {
    return Row(children: strings.map((item) => Text(item)).toList());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Friends"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("Friends"),
          ],
        ),
      ),
    );
  }
}
