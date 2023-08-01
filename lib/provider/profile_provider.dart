import 'package:flutter/material.dart';
import 'package:funsunfront/models/account_model.dart';

import '../services/api_account.dart';

class ProfileProvider extends ChangeNotifier {
  AccountModel? _profile;
  AccountModel? get profile => _profile;

  void updateProfile(String uid) async {
    _profile = await User.getProfile(uid: uid);
    notifyListeners();
  }
}
