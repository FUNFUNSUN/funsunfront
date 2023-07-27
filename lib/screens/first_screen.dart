import 'package:flutter/material.dart';
import 'package:funsunfront/screens/bottom_nav_shortcuts.dart';
import 'package:funsunfront/screens/edit_screen.dart';
import 'package:funsunfront/screens/funding_screen.dart';
import 'package:funsunfront/screens/publicsupport_screen.dart';
import 'package:funsunfront/screens/searchresult_screen.dart';
import '../services/kakao_login_button.dart';
import 'faq_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                const Text(
                  '즐거운\n펀딩플랫폼\nFunSun',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const KakaoLoginButton(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditScreen()),
                    );
                  },
                  child: const Text('editPage로 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FundingScreen()),
                    );
                  },
                  child: const Text('viewPage로 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FaqScreen()),
                    );
                  },
                  child: const Text('FAQ로 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchResultScreen()),
                    );
                  },
                  child: const Text('SearchResultScreen 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavShortcuts()),
                    );
                  },
                  child: const Text('메인화면 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FundingScreen()),
                    );
                  },
                  child: const Text('펀딩 게시글 테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PublicSupportScreen(
                                FundingExpireDate: '2023년7월27일',
                                FundingTitle: '펀딩제목이~~머냐면~~~어쩌구',
                                FundingImage:
                                    'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FczFu0l%2FbtrqAb95DTz%2FEzH59ItsvNjSB8JEOEarkK%2Fimg.png',
                              )),
                    );
                  },
                  child: const Text('PublicSupportScreen 이동 임시테스트'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
