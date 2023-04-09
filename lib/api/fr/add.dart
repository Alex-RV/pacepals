import '../def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AOFriendAdd {
  final bool ok;
  final String error;

  AOFriendAdd.fromJson(Map<String, dynamic> json)
      : ok = json['ok'],
        error = json['error'];
}

class AIFriendAdd {
  final SessionId sid;
  final UserId add;

  AIFriendAdd(this.sid, this.add);
  Map<String, dynamic> toJson() => {
        'sid': sid,
        'add': add,
      };
}

Future<AOFriendAdd> apiFriendsAdd(AIFriendAdd req) async {
  var url = Uri.https('pacepals-961.shuttleapp.rs', '/api/fr/add');
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "access-control-allow-origin": "*",
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Allow-Methods': '*',
  };
  var response =
      await http.post(url, body: jsonEncode(req.toJson()), headers: headers);
  return AOFriendAdd.fromJson(jsonDecode(response.body));
}
