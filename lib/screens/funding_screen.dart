import 'package:flutter/material.dart';
import 'package:funsunfront/models/remit_model.dart';
import 'package:funsunfront/services/api_remit.dart';

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
    final Future<List<RemitModel>> remits = Remit.getRemit(id, '1');
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
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // 오류 표시
                return Text('오류: ${snapshot.error}');
              } else {
                // 로딩 끝났으면 표시가능
                final funding = snapshot.data;
                funding!;

                //날짜 계산
                final leftDays = DateTime.parse(funding.expireOn)
                    .difference(DateTime.now())
                    .inDays;

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
                        AchievementRate(
                            percent: funding.currentAmount /
                                funding.goalAmount, // 달성률
                            date: leftDays > 0 ? leftDays : 0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 50),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              funding.title, // 펀딩제목
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
                              funding.content!, // 펀딩내용
                              style: const TextStyle(
                                fontSize: 16,
                              ),
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
                                height: screenHeight + 50,
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
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            FutureBuilder(
                                future: remits,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // 데이터를 불러오는 동안 로딩 표시
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // 오류 표시
                                    return Text('오류: ${snapshot.error}');
                                  } else {
                                    // 로딩 끝났으면 표시가능
                                    final remits = snapshot.data;
                                    remits!;

                                    return Transform.translate(
                                      offset: const Offset(0, 100),
                                      child: ListView.separated(
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: remits.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  // TODO: 추후 inkwell로 프로필페이지 이동
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                      // 여기선 image.network 못씀
                                                      '$baseurl${remits[index].author.image}'),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      remits[index]
                                                          .author
                                                          .username,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      remits[index].message,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 25),
                                            child: Divider(
                                                thickness: 1,
                                                height: 1,
                                                color: Colors.white),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                }),
                            //여기까지가 댓글
                          ],
                        ),
                        Column(
                          children: [
                            Transform.scale(
                                scale: 1.5,
                                child: Image.asset(
                                    'assets/images/purpleCircles.png')),
                            Transform.translate(
                              offset: const Offset(0, -15),
                              child: Container(
                                width: screenWidth,
                                height: screenHeight,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 178, 159, 255),
                                ),
                              ),
                            ),
                            // 펀딩소식
                            Transform.translate(
                              offset: const Offset(20, 40),
                              child: const Text(
                                '펀딩소식',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        )
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
