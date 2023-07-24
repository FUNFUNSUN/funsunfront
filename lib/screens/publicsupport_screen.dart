import 'package:flutter/material.dart';

class PublicSupportScreen extends StatelessWidget {
  const PublicSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '전체공개펀딩',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffE7F5F6),
                      borderRadius: BorderRadius.circular(15)),
                  height: 900,
                  width: 400,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
