import 'package:flutter/material.dart';
import 'package:funsunfront/widgets/achievement_rate.dart';
import 'package:funsunfront/widgets/pink_btn.dart';

import '../widgets/bottom_navigation_bar.dart';

class FundingScreen extends StatelessWidget {
  const FundingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String testFundingImgUrl =
        'https://m.herotime.co.kr/web/product/big/20200515/852dce30079acc95eb811def40714318.png';
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
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
                const PinkBtn(
                  btnTxt: '펀딩하기',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
