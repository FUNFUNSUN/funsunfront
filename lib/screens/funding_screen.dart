import 'package:flutter/material.dart';

import 'package:funsunfront/widgets/achievement_rate.dart';
import 'package:funsunfront/widgets/pink_btn.dart';

import '../widgets/bottom_navigation_bar.dart';

class FundingScreen extends StatelessWidget {
  const FundingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String testFundingImgUrl =
        'https://m.herotime.co.kr/web/product/big/20200515/852dce30079acc95eb811def40714318.png';
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: const BtmNavBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.6)),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(testFundingImgUrl),
                ),
                const SizedBox(
                  height: 30,
                ),
                const AchievementRate(percent: 0.6, date: 3),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '타이틀텍스트',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    '컨텐트텍스트',
                    style: TextStyle(
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
                        child: Image.asset('assets/images/pinkCircles.png')),
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
        ),
      ),
    );
  }
}
