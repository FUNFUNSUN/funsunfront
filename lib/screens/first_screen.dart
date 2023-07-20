import 'package:flutter/material.dart';
import '../services/kakaoLoginButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text(
              '즐거운\n펀딩플랫폼\nFunSun',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
              ),
            ),
            KakaoLoginButton(),
          ],
        ),
      ),
    );
  }
}
