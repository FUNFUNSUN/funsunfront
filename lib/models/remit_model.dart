class RemitModel {
  int id;
  String message, createdOn;
  Author author;

  RemitModel(
      {required this.id,
      required this.message,
      required this.author,
      required this.createdOn});

  RemitModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        message = json['message'],
        author = json['author'] = Author.fromJson(json['author']),
        createdOn = json['created_on'];
}

class Author {
  String id, username, image;

  Author({required this.id, required this.username, required this.image});

  Author.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        image = json['image'];
}
