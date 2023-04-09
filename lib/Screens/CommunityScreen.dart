import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<String> _friends = [];

  Future<void> _fetchFriends() async {
    final response =
        await http.get(Uri.parse('http://<YOUR_RUST_BACKEND_ADDRESS>/friends'));
    if (response.statusCode == 200) {
      final List<dynamic> friendsJson = jsonDecode(response.body)['friends'];
      setState(() {
        _friends = friendsJson.map((friend) => friend as String).toList();
      });
    } else {
      throw Exception('Failed to fetch friends');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF191414),
        foregroundColor: const Color(0xFF1DB954),
        centerTitle: true,
        title: const Text("Friends"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),

          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _friends.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: CircleAvatar(
                          child: Text(_friends[index].substring(0, 1)),
                        ),
                        title: Text(_friends[index]));
                  }))
        ],
      ),
    );
  }
}
