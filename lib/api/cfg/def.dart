class UserPublicConfig {
  final String name;
  final String profile;
  final String profilePicture;

  UserPublicConfig(this.name, this.profile, this.profilePicture);
  UserPublicConfig.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        profile = json['profile'],
        profilePicture = json['profile_picture'];
  Map<String, dynamic> toJson() => {
        'name': name,
        'profile': profile,
        'profile_picture': profilePicture,
      };
}

class UserPrivateConfig {
  final int weeklyMiles;

  UserPrivateConfig(this.weeklyMiles);
  UserPrivateConfig.fromJson(Map<String, dynamic> json)
      : weeklyMiles = json['weekly_miles'];
  Map<String, dynamic> toJson() => {
        'weekly_miles': weeklyMiles,
      };
}
