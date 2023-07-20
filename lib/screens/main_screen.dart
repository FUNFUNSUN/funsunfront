import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '펀딩을\n시작해보세요!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '\n친구와 서로 펀딩받고, 서포트하세요',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                SizedBox(
                  child: Image.asset('assets/images/giftBox.png'),
                ),
                const Text(
                  '\n내 친구들의 펀딩',
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
