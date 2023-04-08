import './def.dart';
import '../def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AOConfigGet {
  UserPublicConfig publicConfig;
  UserPrivateConfig privateConfig;

  AOConfigGet(this.publicConfig, this.privateConfig);
  AOConfigGet.fromJson(Map<String, dynamic> json)
      : publicConfig = json['public_config'],
        privateConfig = json['private_config'];
}

class AIConfigGet {
  final SessionId sid;

  AIConfigGet(this.sid);
  Map<String, dynamic> toJson() => {
        'sid': sid,
      };
}

Future<AOConfigGet> apiLoginAuth(AIConfigGet req) async {
  var url = Uri.https('pacepals-96.shuttleapp.rs', '/api/cfg/get');
  var response = await http.post(url, body: req.toJson());
  return AOConfigGet.fromJson(jsonDecode(response.body));
}
