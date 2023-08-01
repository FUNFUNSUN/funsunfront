import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/services/api_account.dart';
import 'package:funsunfront/services/kakao_login_api.dart';
import 'package:provider/provider.dart';

class KakaoLoginButton extends StatelessWidget {
  KakaoLoginButton({
    super.key,
  });

  late UserProvider _userProvider;

  void kakaobtn() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'accessToken');
    String kakaotoken = await getKakaoToken();
    if (kakaotoken != 'error') {
      if (value == null) {
        await Account.getAllToken(kakaotoken);
      }
      final user = await Account.accessTokenLogin();
      _userProvider.setLogin(user.id);
      _userProvider.setUser(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: true);
    return GestureDetector(
      onTap: kakaobtn,
      child: Center(
        heightFactor: 5,
        child: Image.asset(
          'assets/images/kakaologin.png',
        ),
      ),
    );
  }
}
