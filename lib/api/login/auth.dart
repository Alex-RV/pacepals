import '../def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AOLoginAuth {
  final UserId uid;
  final SessionId sid;

  AOLoginAuth(this.uid, this.sid);
  AOLoginAuth.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        sid = json['sid'];
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
  var url = Uri.https('pacepals-96.shuttleapp.rs', '/api/login/auth');
  var response = await http.post(url, body: req.toJson());
  return AOLoginAuth.fromJson(jsonDecode(response.body));
}
