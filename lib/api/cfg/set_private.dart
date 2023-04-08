import './def.dart';
import '../def.dart';
import 'package:http/http.dart' as http;

class AIConfigSetPrivate {
  final UserPrivateConfig config;
  final SessionId sid;

  AIConfigSetPrivate(this.sid, this.config);
  Map<String, dynamic> toJson() => {'sid': sid, 'config': config.toJson()};
}

Future<void> apiLoginAuth(AIConfigSetPrivate req) async {
  var url = Uri.https('pacepals-96.shuttleapp.rs', '/api/cfg/set_private');
  await http.post(url, body: req.toJson());
}
