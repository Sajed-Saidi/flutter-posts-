import 'package:social_media/Models/UserModel.dart';

class CommentModel {
  final int id;
  final int postId;
  final int userId;
  final String content;
  final UserModel user;
  CommentModel(
      {required this.id,
      required this.postId,
      required this.userId,
      required this.content,
      required this.user});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      postId: json['postId'],
      userId: json['userId'],
      content: json['content'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'userId': userId,
      'content': content,
      'user': user.toJson(),
    };
  }
}
