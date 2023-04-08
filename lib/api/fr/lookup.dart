import '../def.dart';
import '../cfg/def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AOFriendLookUp {
  final bool isPending;
  final UserPublicConfig config;

  AOFriendLookUp(this.isPending, this.config);
  AOFriendLookUp.fromJson(Map<String, dynamic> json)
      : isPending = json['is_pending'],
        config = json['config'];
}

class AIFriendLookUp {
  final UserId selfUId;
  final UserId lookupUid;

  AIFriendLookUp(this.selfUId, this.lookupUid);
  Map<String, dynamic> toJson() => {
        'self_uid': selfUId,
        'lookup_uid': lookupUid,
      };
}

Future<AOFriendLookUp> apiFriendsLookUp(AIFriendLookUp req) async {
  var url = Uri.https('pacepals-96.shuttleapp.rs', '/api/login/auth');
  var response = await http.post(url, body: req.toJson());
  return AOFriendLookUp.fromJson(jsonDecode(response.body));
}
