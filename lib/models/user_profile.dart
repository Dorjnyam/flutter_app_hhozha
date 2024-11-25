class UserProfile {
  String id;
  String username;
  String email;
  String? firstName;
  String? lastName;
  double money;
  String? profilePictureUrl;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    required this.money,
    this.profilePictureUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      money: (json['money'] as num).toDouble(),
      profilePictureUrl: json['profile_picure_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'money': money,
      'profile_picture_url': profilePictureUrl,
    };
  }
}
