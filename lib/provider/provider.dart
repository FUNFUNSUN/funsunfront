import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  bool _signIn = false;

  bool get signIn => _signIn;

  void setTrue() {
    _signIn = true;
    notifyListeners();
  }

  void setFalse() {
    _signIn = false;
    notifyListeners();
  }
}


//           https://totally-developer.tistory.com/83
//위 링크 참고