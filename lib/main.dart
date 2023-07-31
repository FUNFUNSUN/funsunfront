import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/models/account_model.dart';
import 'package:funsunfront/provider/provider.dart';
import 'package:funsunfront/screens/bottom_nav_shortcuts.dart';
import 'package:funsunfront/screens/first_screen.dart';
import 'package:funsunfront/services/api_account.dart';
import 'package:funsunfront/services/create_material_color.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:provider/provider.dart';

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
        primarySwatch: createMaterialColor(const Color(0xffFF80C0)),
      ),
      home: ChangeNotifierProvider<SignInProvider>(
        create: (context) => SignInProvider(),
        child: const FunsunApp(),
      ),
    ),
  );
}

class FunsunApp extends StatefulWidget {
  const FunsunApp({super.key});

  @override
  State<FunsunApp> createState() => _FunsunAppState();
}

class _FunsunAppState extends State<FunsunApp> {
  late SignInProvider _signInProvider;
  late bool isSignIn;
  late AccountModel user;

  void initfuction() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'accessToken');

    if (value != null) {
      setState(() {
        _signInProvider.setTrue();
      });
      user = await Account.accessTokenLogin(false);
      print(user);
    } else {
      setState(() {
        _signInProvider.setFalse();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _signInProvider = Provider.of<SignInProvider>(context, listen: false);
    initfuction();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInProvider>(builder: (context, provider, child) {
      isSignIn = provider.signIn;
      return isSignIn ? const BottomNavShortcuts() : const FirstScreen();
    });
  }
}
