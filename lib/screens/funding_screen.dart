import 'package:flutter/material.dart';

import 'package:funsunfront/widgets/achievement_rate.dart';
import 'package:funsunfront/widgets/pink_btn.dart';

import '../widgets/bottom_navigation_bar.dart';

class FundingScreen extends StatelessWidget {
  // final FundingModel funding;
  // final List<CommentModel> commentList;

  const FundingScreen({
    // required this.funding,
    // required this.commentList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String testFundingImgUrl =
        'https://m.herotime.co.kr/web/product/big/20200515/852dce30079acc95eb811def40714318.png';
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    //__________테스트 데이터__________//
    Map<String, String> testFunding = {
      "id": '1',
      "title": "안녕? 난 청소부 신이라고 해\n인간들을 청소하는 일을 하지",
      "content":
          "평소에 쓰는 망치가 무뎌져서 사람들이 한번에 잘 안죽어용 ;(\n새 망치를 사고 싶은데 청소부용 망치는 가격이 꽤 나가더라구.. 너희가 돈을 모아줘서 너희를 청소하지않게 해줘 ^^",
      "goal_amount": '10000000',
      "current_amount": '100000',
      "expire_on": "2023-07-26T17:24:38.718386+09:00",
      "created_on": "2023-07-26T14:40:23.409035+09:00",
      "updated_on": "2023-07-26T14:~40:57.333162+09:00",
      "public": 'true',
      "image":
          'https://m.herotime.co.kr/web/product/big/20200515/852dce30079acc95eb811def40714318.png',
      "author": "sinChan"
    };

    List<Map<String, String>> testCommentList = [];
    Map<String, String> commentSample01 = {
      'id': '123',
      'username': 'NoI',
      'image': 'https://pbs.twimg.com/media/E50qARNVoAE7k2U.jpg',
      'message': '오마에 붓코로스'
    };
    Map<String, String> commentSample02 = {
      'id': '1223',
      'username': '부짜라띠',
      'image':
          'https://photo.coolenjoy.co.kr/data/editor/1810/thumb-Bimg_20181006224426_fzzvbpvz.png',
      'message': '거짓말을 하는 맛이네요'
    };
    testCommentList.add(commentSample01);
    testCommentList.add(commentSample02);

    //__________테스트 데이터__________//

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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      testFunding['title']!,
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
                    testFunding['content']!,
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
                    ListView.builder(
                      itemCount: testCommentList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(testCommentList[index]['message']!),
                        );
                      },
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
