class FundingModel {
  final String id,
      title,
      content,
      goalAmount,
      currentAmount,
      expireOn,
      createdOn,
      updatedOn,
      public,
      image,
      author;

  FundingModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        goalAmount = json['goal_amount'],
        currentAmount = json['current_amount'],
        expireOn = json['exprie_on'],
        createdOn = json['created_on'],
        updatedOn = json['updated_on'],
        public = json['public'],
        image = json['image'],
        author = json['admin'];
}
