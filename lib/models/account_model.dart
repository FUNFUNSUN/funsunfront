class AccountModel {
  String id = 'admin',
      email = 'admin@admin.com',
      birthday = '0404',
      username = 'thxkyu',
      gender = 'male';
  String? image;
  int? follower, followee;

  AccountModel(
      {required this.id,
      required this.email,
      required this.birthday,
      required this.username,
      this.image,
      this.follower,
      this.followee});

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    birthday = json['birthday'];
    username = json['username'];
    image = json['image'];
    follower = json['follower'];
    followee = json['followee'];
  }
}
