import 'package:flutter/material.dart';
import 'package:funsunfront/models/account_model.dart';

import '../services/api_account.dart';

class UserProvider extends ChangeNotifier {
  String? _logged = 'loading';
  String? get logged => _logged;

  AccountModel? _user;
  AccountModel? get user => _user;

  void setLogin(String status) {
    _logged = status;
    notifyListeners();
  }

  void setUser(AccountModel user) {
    _user = user;
    notifyListeners();
  }

  void updateUser() async {
    _user = await Account.accessTokenLogin(2);
    notifyListeners();
  }
}

//           https://totally-developer.tistory.com/83
//위 링크 참고
