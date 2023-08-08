import 'package:flutter/material.dart';
import 'package:funsunfront/models/account_model.dart';

import '../services/api_account.dart';

class UserProvider extends ChangeNotifier {
  String? _logged = '';
  String? get logged => _logged;

  AccountModel? _user;
  AccountModel? get user => _user;
/*
  File? _profileImage;
  File? get profileImage => _profileImage;

  void setProfileImage(File image) {
    _profileImage = image;
    notifyListeners();
  }
  */

  void setLogin(String status) {
    _logged = status;
    notifyListeners();
  }

  void setUser(AccountModel user) {
    _user = user;
    notifyListeners();
  }

  void updateUser() async {
    _user = await User.accessTokenLogin();
    if (_user!.image != null) {
      _user!.image =
          '${_user!.image}?v=${DateTime.now().millisecondsSinceEpoch}';
    }

    notifyListeners();
  }
}

//           https://totally-developer.tistory.com/83
//위 링크 참고
