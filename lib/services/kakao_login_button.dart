// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/provider/profile_provider.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/services/api_account.dart';
import 'package:funsunfront/services/kakao_login_api.dart';
import 'package:provider/provider.dart';

class KakaoLoginButton extends StatelessWidget {
  KakaoLoginButton({
    super.key,
  });

  late UserProvider _userProvider;
  late FundingsProvider _fundingsProvider;
  late ProfileProvider _profileProvider;

  void kakaobtn() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'accessToken');
    String kakaotoken = await getKakaoToken();
    if (kakaotoken != 'error') {
      if (value == null) {
        await FunsunUser.getAllToken(kakaotoken);
      }
      final user = await FunsunUser.accessTokenLogin();
      _userProvider.setLogin(user.id);
      _userProvider.setUser(user);
      _fundingsProvider.getMyfundings(_userProvider.user!.id, 1);
      _fundingsProvider.getJoinedfundings(1);
      _fundingsProvider.getPublicFundings(1);
      _fundingsProvider.getFriendFundings(1);
      _profileProvider.updateProfile(_userProvider.user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _fundingsProvider = Provider.of<FundingsProvider>(context, listen: false);
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: kakaobtn,
      child: Center(
        heightFactor: 5,
        child: Image.asset(
          'assets/images/kakaologin.png',
          width: screenWidth * 0.6,
        ),
      ),
    );
  }
}
