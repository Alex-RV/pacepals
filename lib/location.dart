class UserLocation {
  final double latitude;
  final double longitude;

  UserLocation(this.latitude, this.longitude);
}

UserLocation getLocation() {
  return UserLocation(-122.415336, 37.730068);
}
