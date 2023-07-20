import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
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
              // Image(image: image) 카카오로그인 이미지
            ],
          ),
        ),
      ),
    );
  }
}
