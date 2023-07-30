import 'package:flutter/material.dart';

import 'package:funsunfront/widgets/achievement_rate.dart';
import 'package:funsunfront/widgets/pink_btn.dart';

import '../models/funding_model.dart';
import '../services/api_funding.dart';
import '../widgets/bottom_navigation_bar.dart';

class FundingScreen extends StatelessWidget {
  final String id;
  const FundingScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<FundingModel> funding = Funding.getFunding(id);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    return Scaffold(
      bottomNavigationBar: const BtmNavBarWidget(),
      body: SafeArea(
        child: FutureBuilder(
            future: funding,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 데이터를 불러오는 동안 로딩 표시
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // 오류 표시
                return Text('오류: ${snapshot.error}');
              } else {
                // 로딩 끝났으면 표시가능
                final funding = snapshot.data;
                funding!;

                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          width: screenWidth * 0.8,
                          height: screenWidth * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.6)),
                          clipBehavior: Clip.hardEdge,
                          child: Image.network('$baseurl${funding.image}'),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const AchievementRate(percent: 0.6, date: 3),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 50),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              funding.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            funding.content,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: PinkBtn(
                            btnTxt: '펀딩하기',
                          ),
                        ),
                        Stack(
                          children: [
                            Transform.scale(
                                scale: 1.5,
                                child: Image.asset(
                                    'assets/images/pinkCircles.png')),
                            Transform.translate(
                              offset: const Offset(0, 15),
                              child: Container(
                                width: screenWidth,
                                height: screenHeight * 0.5,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 159, 208),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(20, 40),
                              child: const Text(
                                '축하메세지',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
