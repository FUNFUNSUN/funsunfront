import 'package:flutter/material.dart';
import 'package:funsunfront/models/remit_model.dart';
import 'package:funsunfront/services/api_remit.dart';

import 'package:funsunfront/widgets/achievement_rate.dart';
import 'package:funsunfront/widgets/loading_circle.dart';
import 'package:funsunfront/widgets/pink_btn.dart';

import '../models/funding_model.dart';
import '../services/api_funding.dart';

class FundingScreen extends StatelessWidget {
  final String id;
  const FundingScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<FundingModel> funding = Funding.getFunding(id: id);
    final Future<List<RemitModel>> remits = Remit.getRemit(id: id, page: '1');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: funding,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 데이터를 불러오는 동안 로딩 표시
              return const LoadingCircle();
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
                      .inDays +
                  1;

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
                              .withOpacity(0.6),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(
                          funding.image != null
                              ? '$baseurl${funding.image}'
                              : 'https://m.herotime.co.kr/web/product/big/20200515/852dce30079acc95eb811def40714318.png',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AchievementRate(
                        percent: funding.currentAmount! / funding.goalAmount,
                        date: leftDays > 0 ? leftDays : 0,
                      ),
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
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            funding.content!,
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
                      Column(
                        children: [
                          Transform.translate(
                            offset: const Offset(0, 15),
                            child: Transform.scale(
                              scale: 1.5,
                              child:
                                  Image.asset('assets/images/pinkCircles.png'),
                            ),
                          ),
                          Container(
                            color: const Color.fromARGB(255, 255, 159, 208),
                            width: screenWidth,
                            height: 80,
                            child: Transform.translate(
                              offset: const Offset(20, 20),
                              child: const Text(
                                '축하메세지',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: remits,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // 데이터를 불러오는 동안 로딩 표시
                                return const LoadingCircle();
                              } else if (snapshot.hasError) {
                                // 오류 표시
                                return Text('오류: ${snapshot.error}');
                              } else {
                                // 로딩 끝났으면 표시가능
                                final remits = snapshot.data;
                                remits!;

                                return Column(
                                  children: [
                                    for (final remit
                                        in remits) //listview 안쓰고 for문으로
                                      Container(
                                        color: const Color.fromARGB(
                                            255, 255, 159, 208),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    // TODO: 추후 inkwell로 프로필페이지 이동
                                                    radius: 30,
                                                    backgroundImage: remit
                                                                .author.image !=
                                                            null
                                                        ? NetworkImage(
                                                            '$baseurl${remit.author.image}',
                                                          )
                                                        : Image.asset(
                                                                'assets/images/giftBox.png')
                                                            .image,
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        remit.author.username,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${remit.message} ${remit.id}',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: Divider(
                                                  color: Colors.white,
                                                  thickness: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              }
                            },
                          ),
                          // 여기까지가 댓글
                          if (funding.review != null)
                            Column(
                              children: [
                                Container(
                                  color:
                                      const Color.fromARGB(255, 255, 159, 208),
                                  height: 50,
                                ),
                                Transform.translate(
                                  offset: const Offset(0, -15),
                                  child: Transform.scale(
                                    scale: 1.5,
                                    child: Image.asset(
                                        'assets/images/purpleCircles.png'),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(0, -30),
                                  child: Container(
                                    color: const Color.fromARGB(
                                        255, 178, 159, 255),
                                    width: screenWidth,
                                    height: 500,
                                    child: Transform.translate(
                                      offset: const Offset(20, 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '펀딩 후기',
                                            style: TextStyle(
                                              fontSize: 27,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          if (funding.reviewImage != null)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 30),
                                              child: Container(
                                                width: screenWidth * 0.8,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Theme.of(context)
                                                      .primaryColorDark
                                                      .withOpacity(0.6),
                                                ),
                                                clipBehavior: Clip.hardEdge,
                                                child: Image.network(
                                                  '$baseurl${funding.reviewImage}',
                                                ),
                                              ),
                                            ),
                                          Text(
                                            funding.review!,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
