import '../def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AOFriendGet {
  final bool ok;
  final String error;
  final List<UserId> pendingAdds;
  final List<UserId> friends;

  AOFriendGet.fromJson(Map<String, dynamic> json)
      : pendingAdds = json['pending_adds'],
        friends = json['friends'],
        ok = json['ok'],
        error = json['error'];
}

class AIFriendGet {
  final SessionId sid;

  AIFriendGet(this.sid);
  Map<String, dynamic> toJson() => {
        'sid': sid,
      };
}

Future<AOFriendGet> apiFriendsLookUp(AIFriendGet req) async {
  var url = Uri.https('pacepals-961.shuttleapp.rs', '/api/fr/get');
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "access-control-allow-origin": "*",
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Allow-Methods': '*',
  };
  var response =
      await http.post(url, body: jsonEncode(req.toJson()), headers: headers);
  return AOFriendGet.fromJson(jsonDecode(response.body));
}
