import 'package:flutter/material.dart';
import 'package:funsunfront/screens/editPage.dart';
import 'package:funsunfront/screens/main_screen.dart';
import 'package:funsunfront/screens/userPage.dart';
import '../services/kakaoLoginButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
              child: const Text('메인화면으로 이동 임시테스트'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditPage()),
                );
              },
              child: const Text('editPage로 이동 임시테스트'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserPage()),
                );
              },
              child: const Text('userPage로 이동 임시테스트'),
            ),
          ],
        ),
      ),
    );
  }
}
