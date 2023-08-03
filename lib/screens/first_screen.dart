import 'package:flutter/material.dart';
import '../services/kakao_login_button.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                const Text(
                  '즐거운\n펀딩플랫폼\nFunSun',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard'),
                ),
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/images/three_gifts.png',
                  width: screenWidth * 0.8,
                ),
                Transform.translate(
                    offset: const Offset(0, -50), child: KakaoLoginButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
