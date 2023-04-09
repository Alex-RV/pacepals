import 'dart:convert';

import './def.dart';
import '../def.dart';
import 'package:http/http.dart' as http;

class AIConfigSetPrivate {
  final UserPrivateConfig config;
  final SessionId sid;

  AIConfigSetPrivate(this.sid, this.config);
  Map<String, dynamic> toJson() => {'sid': sid, 'config': config.toJson()};
}

Future<void> apiConfigSetPrivate(AIConfigSetPrivate req) async {
  var url = Uri.https('pacepals-961.shuttleapp.rs', '/api/cfg/set_private');
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  await http.post(url, body: jsonEncode(req.toJson()), headers: headers);
}
