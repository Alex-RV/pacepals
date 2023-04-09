import '../def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AOFriendGet {
  final List<UserId> pendingAdds;
  final List<UserId> friends;

  AOFriendGet(this.pendingAdds, this.friends);
  AOFriendGet.fromJson(Map<String, dynamic> json)
      : pendingAdds = json['pending_adds'],
        friends = json['friends'];
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
  };
  var response = await http.post(url, body: jsonEncode(req.toJson()), headers: headers);
  return AOFriendGet.fromJson(jsonDecode(response.body));
}
