import './def.dart';
import '../def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AOConfigGet {
  final bool ok;
  final String error;
  UserPublicConfig publicConfig;
  UserPrivateConfig privateConfig;

  AOConfigGet.fromJson(Map<String, dynamic> json)
      : publicConfig = json['public_config'],
        privateConfig = json['private_config'],
        ok = json['ok'],
        error = json['error'];
}

class AIConfigGet {
  final SessionId sid;

  AIConfigGet(this.sid);
  Map<String, dynamic> toJson() => {
        'sid': sid,
      };
}

Future<AOConfigGet> apiConfigGet(AIConfigGet req) async {
  var url = Uri.https('pacepals-961.shuttleapp.rs', '/api/cfg/get');
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  var response =
      await http.post(url, body: jsonEncode(req.toJson()), headers: headers);
  return AOConfigGet.fromJson(jsonDecode(response.body));
}
