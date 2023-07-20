import 'package:flutter/material.dart';
import '../services/kakaoLoginButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: const KakaoLoginButton(),
    );
  }
}
