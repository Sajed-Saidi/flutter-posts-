class LikeModel {
  final int id;
  final int postId;
  final int userId;

  LikeModel({required this.id, required this.postId, required this.userId});

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
        id: json['id'], postId: json['postId'], userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'postId': postId, 'userId': userId};
  }
}
