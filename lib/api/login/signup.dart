import '../def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AOLoginSignup {
  final bool ok;
  final String error;
  final UserId uid;

  AOLoginSignup.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        ok = json['ok'],
        error = json['error'];
}

class AILoginSignup {
  final String email;
  final String password;

  AILoginSignup(this.email, this.password);
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

Future<AOLoginSignup> apiLoginSignup(AILoginSignup req) async {
  var url = Uri.https('pacepals-961.shuttleapp.rs', '/api/login/signup');
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "access-control-allow-origin": "*",
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Allow-Methods': '*',
  };
  var response =
      await http.post(url, body: jsonEncode(req.toJson()), headers: headers);
  return AOLoginSignup.fromJson(jsonDecode(response.body));
}
