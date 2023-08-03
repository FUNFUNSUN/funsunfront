import 'package:flutter/material.dart';
import 'package:funsunfront/models/remit_model.dart';
import 'package:funsunfront/provider/profile_provider.dart';
import 'package:funsunfront/screens/remit_screen.dart';
import 'package:funsunfront/screens/userscreen.dart';
import 'package:funsunfront/services/api_remit.dart';

import 'package:funsunfront/widgets/achievement_rate.dart';
import 'package:funsunfront/widgets/loading_circle.dart';
import 'package:provider/provider.dart';

import '../models/funding_model.dart';
import '../provider/user_provider.dart';
import '../services/api_funding.dart';
import '../widgets/pink_btn.dart';
import '../widgets/report_icon.dart';
import 'fundig_edit_screen.dart';

class FundingScreen extends StatelessWidget {
  final String id;
  FundingScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  late UserProvider _userProvider;
  late ProfileProvider profileProvider;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: true);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
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

              print('펀딩에 등록된 시간 ${DateTime.parse(funding.expireOn)}');
              print('현재 시간 ${DateTime.now()}');

              final ex = DateTime.parse(funding.expireOn)
                  .difference(DateTime.now())
                  .toString();

              int tempDifference =
                  int.parse((ex.substring(0, ex.indexOf(':'))));

              final leftDays = tempDifference ~/ 24;
              print('차이나는 날짜만 출력 : $leftDays');

              final leftHours = tempDifference - leftDays * 24;
              print('차이나는 시간만 출력 : $leftHours');

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
                        child: (funding.image != null)
                            ? Image.network(
                                '$baseurl${funding.image}',
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/default_funding.jpg',
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AchievementRate(
                        percent: funding.currentAmount! / funding.goalAmount,
                        date: leftDays > 0 ? leftDays : 0,
                        hour: leftHours > 0 ? leftHours : 0,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      (funding.author!['id'] == _userProvider.user!.id)
                          ? Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('수정하기'),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              FundingEditScreen(
                                            origin: funding,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: GestureDetector(
                            onTap: () {
                              String id = funding.id!.toString();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RemitScreen(
                                          targetFunding: funding,
                                        )),
                              );
                            },
                            child: const PinkBtn(
                              btnTxt: '펀딩하기',
                            ),
                          )),
                      (funding.author!['id'] == _userProvider.user!.id)
                          ? const SizedBox()
                          : ReportIcon(funding.id!, 'funding', ''),
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
                                                  InkWell(
                                                    onTap: () async {
                                                      await profileProvider
                                                          .updateProfile(
                                                              remit.author.id);
                                                      if (context.mounted) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                UserScreen(
                                                                    id: remit
                                                                        .author
                                                                        .id),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: CircleAvatar(
                                                      // TODO: 추후 inkwell로 프로필페이지 이동
                                                      radius: 30,
                                                      backgroundImage: remit
                                                                  .author
                                                                  .image !=
                                                              null
                                                          ? NetworkImage(
                                                              '$baseurl${remit.author.image}',
                                                            )
                                                          : Image.asset(
                                                                  'assets/images/default_funding.jpg')
                                                              .image,
                                                    ),
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
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.7,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'From. ${remit.author.username}',
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                            ),
                                                            (remit.author.id
                                                                        .toString() ==
                                                                    _userProvider
                                                                        .user!
                                                                        .id)
                                                                ? const SizedBox()
                                                                : ReportIcon(
                                                                    remit.id
                                                                        .toString(),
                                                                    'remit',
                                                                    ''),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.7,
                                                        child: Text(
                                                          remit.message,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
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
