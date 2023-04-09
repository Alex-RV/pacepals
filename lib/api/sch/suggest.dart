import '../def.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps/google_maps_places.dart';

class AOLoginAuth {
  final bool ok;
  final String error;
  final UserId uid;
  final SessionId sid;

  AOLoginAuth.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        sid = json['sid'],
        ok = json['ok'],
        error = json['error'];
}

class Location {
  final double latitude;
  final double longitude;
  Location(this.latitude, this.longitude);
  Map<String, dynamic> toJson() =>
      {'latitude': latitude, 'longitude': longitude};
}

class PlaceResponse {
  final List<PlaceResult> results;
  PlaceResponse.fromJson(Map<String, dynamic> json) : results = json['results'];
}

class AOScheduleSuggest {
  final bool ok;
  final String error;
  final List<PlaceResult> nearby;
  AOScheduleSuggest.fromJson(Map<String, dynamic> json)
      : ok = json['ok'],
        error = json['error'],
        nearby = json['nearby'];
}

class AIScheduleSuggest {
  final Location location;

  AIScheduleSuggest(this.location);
  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
      };
}

Future<AOScheduleSuggest> apiScheduleSuggest(AIScheduleSuggest req) async {
  var url = Uri.https('pacepals-961.shuttleapp.rs', '/api/sch/suggest');
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "access-control-allow-origin": "*",
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Allow-Methods': '*',
  };
  var response =
      await http.post(url, body: jsonEncode(req.toJson()), headers: headers);
  return AOScheduleSuggest.fromJson(jsonDecode(response.body));
}
