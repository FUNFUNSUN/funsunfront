import 'package:flutter/cupertino.dart';

import 'kakaoLoginApi.dart';

class KakaoLoginButton extends StatelessWidget {
  const KakaoLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: kakaoLogin,
      child: Center(
        heightFactor: 15, //추후 높이조절요망
        child: Image.asset('assets/images/kakaologin.png'),
      ),
    );
  }
}
