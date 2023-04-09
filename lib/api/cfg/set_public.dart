import './def.dart';
import '../def.dart';
import 'package:http/http.dart' as http;

class AIConfigSetPublic {
  final UserPublicConfig config;
  final SessionId sid;

  AIConfigSetPublic(this.sid, this.config);
  Map<String, dynamic> toJson() => {'sid': sid, 'config': config.toJson()};
}

Future<void> apiConfigSetPublic(AIConfigSetPublic req) async {
  var url = Uri.https('pacepals-961.shuttleapp.rs', '/api/cfg/set_public');
  await http.post(url, body: req.toJson());
}
