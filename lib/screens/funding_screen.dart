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
    final screenHeight = MediaQuery.of(context).size.height;
    const String fundingTitle = '안녕? 난 청소부 신이라고 해\n인간들을 청소하는 일을 하지';
    const String fundingContentText =
        '평소에 쓰는 망치가 무뎌져서 사람들이 한번에 잘 안죽어용 ;(\n새 망치를 사고 싶은데 청소부용 망치는 가격이 꽤 나가더라구.. 너희가 돈을 모아줘서 너희를 청소하지않게 해줘 ^^';
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
                      fundingTitle,
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
                    fundingContentText,
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
                    Image.asset('assets/images/pinkCircles.png'),
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
