import 'package:flutter/cupertino.dart';

import 'kakao_login_api.dart';

class KakaoLoginButton extends StatelessWidget {
  const KakaoLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: kakaoLogin,
      child: Center(
        heightFactor: 5,
        child: Image.asset(
          'assets/images/kakaologin.png',
        ),
      ),
    );
  }
}
