import './def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AOLoginSignup {
  final UserId uid;

  AOLoginSignup(this.uid);
  AOLoginSignup.fromJson(Map<String, dynamic> json) : uid = json['uid'];
}

class AILoginSignup {
  final String username;
  final String password;

  AILoginSignup(this.username, this.password);
  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

Future<AOLoginSignup> apiLoginSignup(AILoginSignup req) async {
  var url = Uri.https('pacepals-96.shuttleapp.rs', '/api/login/signup');
  var response = await http.post(url, body: req.toJson());
  return AOLoginSignup.fromJson(jsonDecode(response.body));
}
