import './def.dart';
import '../def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AIConfigSetPublic {
  final UserPublicConfig config;
  final SessionId sid;

  AIConfigSetPublic(this.sid, this.config);
  Map<String, dynamic> toJson() => {'sid': sid, 'config': config.toJson()};
}

Future<void> apiConfigSetPublic(AIConfigSetPublic req) async {
  var url = Uri.https('pacepals-961.shuttleapp.rs', '/api/cfg/set_public');
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  await http.post(url, body: jsonEncode(req.toJson()), headers: headers);
}
