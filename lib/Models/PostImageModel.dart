class PostImageModel {
  final int id;
  final String imageName;
  final int postId;

  PostImageModel(
      {required this.id, required this.imageName, required this.postId});

  factory PostImageModel.fromJson(Map<String, dynamic> json) => PostImageModel(
        id: json['id'] as int,
        imageName: json['image_name'] as String,
        postId: json['post_id'] as int,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_name': imageName,
      'post_id': postId,
    };
  }
}
