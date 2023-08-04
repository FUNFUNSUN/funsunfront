class AccountModel {
  String id, email, username;
  String? image, birthday, gender, bankAccount;
  int follower, followee;

  AccountModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        birthday = json['birthday'],
        username = json['username'],
        bankAccount = json['bank_account'],
        image = json['image'],
        follower = json['follower'],
        gender = json['gender'],
        followee = json['followee'];
}
