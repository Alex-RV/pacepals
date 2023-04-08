// import '../def.dart';
// import '../cfg/def.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AOFriendGet {
//     final SessionId sid;

//   AOFriendGet(this.sid);
//   AOFriendGet.fromJson(Map<String, dynamic> json)
//       : sid = json['sid'],
//         config = json['config'];
// }

// class AIFriendGet {
//   final UserId selfUId;
//   final UserId lookupUid;

//   AIFriendLookUp(this.selfUId, this.lookupUid);
//   Map<String, dynamic> toJson() => {
//         'self_uid': selfUId,
//         'lookup_uid': lookupUid,
//       };
// }

// Future<AOFriendLookUp> apiLoginAuth(AIFriendLookUp req) async {
//   var url = Uri.https('pacepals-96.shuttleapp.rs', '/api/login/auth');
//   var response = await http.post(url, body: req.toJson());
//   return AOFriendLookUp.fromJson(jsonDecode(response.body));
// }
