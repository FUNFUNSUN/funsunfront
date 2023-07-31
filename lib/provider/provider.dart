import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  String? _currentUser = 'loading';
  String? get currentUser => _currentUser;

  void setCurrentUser(String uid) {
    _currentUser = uid;
    notifyListeners();
  }
}

//           https://totally-developer.tistory.com/83
//위 링크 참고
