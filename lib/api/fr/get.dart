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
  var url = Uri.https('pacepals-96.shuttleapp.rs', '/api/fr/get');
  var response = await http.post(url, body: req.toJson());
  return AOFriendGet.fromJson(jsonDecode(response.body));
}
