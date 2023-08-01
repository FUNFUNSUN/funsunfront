import 'package:flutter/material.dart';

import '../widgets/achievement_rate.dart';

class PreviewScreen extends StatelessWidget {
  final Map<String, dynamic> temp;
  const PreviewScreen({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final leftDays =
        DateTime.parse(temp['expire_on']).difference(DateTime.now()).inDays;

    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              Container(
                width: screenWidth * 0.8,
                height: screenWidth * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).primaryColorDark.withOpacity(0.6),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  temp['image'] != null
                      ? '$baseurl${temp['image']}'
                      : 'https://m.herotime.co.kr/web/product/big/20200515/852dce30079acc95eb811def40714318.png',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AchievementRate(
                percent: 0,
                date: leftDays > 0 ? leftDays : 0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    temp['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    temp['content'],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
