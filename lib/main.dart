import 'package:flutter/material.dart';
import 'package:funsunfront/screens/bottom_nav_shortcuts.dart';
import 'package:funsunfront/screens/first_screen.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '9ecb696dfb252954d4b0e25baa41d134',
    javaScriptAppKey: 'b68e9fa854b4cd621e3999bd34b46a85',
  );

  runApp(
    MaterialApp(
      title: 'FunSun',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const FunsunApp(),
    ),
  );
}

class FunsunApp extends StatelessWidget {
  const FunsunApp({super.key});

  final bool isSignIn = true;
  // Todo : 추후 실제 상태에 따라 final 지우고 isSignIn에 대입
  @override
  Widget build(BuildContext context) {
    return isSignIn ? const BottomNavShortcuts() : const FirstScreen();
  }
}
