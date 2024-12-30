import 'package:social_media/Models/UserProfileModel.dart';

class UserModel {
  final int id;
  final String fullName;
  final String username;
  final String email;
  final String? token;
  final UserProfileModel? profile;

  UserModel(
      {required this.id,
      required this.fullName,
      required this.username,
      required this.email,
      this.token,
      this.profile});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      username: json['username'],
      token: json['token'],
      profile: json['profile'] != null
          ? UserProfileModel.fromJson(json['profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'username': username,
    };
  }

  @override
  String toString() {
    return 'UserModel{fullName: $fullName,usernameL $username , email: $email} ${profile.toString()}';
  }
}
