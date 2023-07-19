import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void kakaoLogin() async {
    // var data = await KakaoSdk.origin;
    // print(data);
    // 카카오톡 실행 가능 여부 확인
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        print(token);
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          User user = await UserApi.instance.me();
          print('카카오계정으로 로그인 성공');
          print(token);
          print(user);
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        User user = await UserApi.instance.me();
        print('카카오계정으로 로그인 성공');
        print(token);
        print(user);
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          title: const Text(
            '윤선이와 친구들',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
        body: GestureDetector(
          onTap: kakaoLogin,
          child: Image.asset('assets/images/kakaologin.png'),
        ));
  }
}
