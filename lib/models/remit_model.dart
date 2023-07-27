class RemitModel {
  final String id, amount, createdOn, message, author, funding;

  RemitModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        amount = json['amount'],
        createdOn = json['created_on'],
        message = json['message'],
        author = json['author'],
        funding = json['funding'];
}
