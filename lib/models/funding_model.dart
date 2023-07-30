class FundingModel {
  final int id, goalAmount, currentAmount;
  final bool? public;
  final String title, content, expireOn;
  final String? createdOn, image;
  final Map<String, dynamic> author;

  FundingModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        goalAmount = json['goal_amount'],
        currentAmount = json['current_amount'],
        expireOn = json['expire_on'],
        createdOn = json['created_on'],
        public = json['public'],
        image = json['image'],
        author = json['author'];
}
