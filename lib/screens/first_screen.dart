import 'package:flutter/material.dart';
import '../services/kakao_login_button.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFDC0DB),
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
                Stack(children: [
                  ClipOval(
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenWidth * 0.8,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                  Image.asset(
                    'assets/images/three_gifts.png',
                    width: screenWidth * 0.8,
                  ),
                ]),
                Transform.translate(
                    offset: const Offset(0, 25),
                    child: Container(
                        height: 90,
                        width: 250,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.2),
                              spreadRadius: 0.2,
                              blurRadius: 20,
                              offset: const Offset(
                                  4, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: KakaoLoginButton())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
