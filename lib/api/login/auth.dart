import '../def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AOLoginAuth {
  final bool ok;
  final String error;
  final UserId uid;
  final SessionId sid;

  AOLoginAuth.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        sid = json['sid'],
        ok = json['ok'],
        error = json['error'];
}

class AILoginAuth {
  final String email;
  final String password;

  AILoginAuth(this.email, this.password);
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

Future<AOLoginAuth> apiLoginAuth(AILoginAuth req) async {
  var url = Uri.https('pacepals-961.shuttleapp.rs', '/api/login/auth');
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  var response =
      await http.post(url, body: jsonEncode(req.toJson()), headers: headers);
  return AOLoginAuth.fromJson(jsonDecode(response.body));
}
