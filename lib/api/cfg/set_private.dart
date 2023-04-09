import 'dart:convert';

import './def.dart';
import '../def.dart';
import 'package:http/http.dart' as http;

class AOConfigSetPrivate {
  final bool ok;
  final String error;

  AOConfigSetPrivate.fromJson(Map<String, dynamic> json)
      : ok = json['ok'],
        error = json['error'];
}

class AIConfigSetPrivate {
  final UserPrivateConfig config;
  final SessionId sid;

  AIConfigSetPrivate(this.sid, this.config);
  Map<String, dynamic> toJson() => {'sid': sid, 'config': config.toJson()};
}

Future<AOConfigSetPrivate> apiConfigSetPrivate(AIConfigSetPrivate req) async {
  var url = Uri.https('pacepals-961.shuttleapp.rs', '/api/cfg/set_private');
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  var response =
      await http.post(url, body: jsonEncode(req.toJson()), headers: headers);
  return AOConfigSetPrivate.fromJson(jsonDecode(response.body));
}
