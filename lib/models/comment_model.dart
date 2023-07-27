class CommentModel {
  final String id, message, username, image;
  // 백에선 image 인데 Flutter에서 Image와 구분위해 imageUrl로 씀
  CommentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        image = json['image'],
        message = json['message'];
}
