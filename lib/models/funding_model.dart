class FundingModel {
  final int goalAmount;
  final int? id, currentAmount;
  final bool? public;
  // true 전체공개
  final String title, expireOn;
  final String? createdOn, content, image, review, reviewImage, authorName;
  final Map<String, dynamic>? author;

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
        author = json['author'],
        review = json['review'],
        reviewImage = json['review_image'],
        authorName = json['author_name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['goal_amount'] = goalAmount;
    data['expire_on'] = expireOn;
    data['public'] = public;
    return data;
  }
}
