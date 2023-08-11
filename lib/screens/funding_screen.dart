// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:funsunfront/models/remit_model.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/provider/profile_provider.dart';
import 'package:funsunfront/screens/funding_delete_screen.dart';
import 'package:funsunfront/screens/my_screen.dart';
import 'package:funsunfront/screens/remit_screen.dart';
import 'package:funsunfront/screens/review_screen.dart';
import 'package:funsunfront/screens/userscreen.dart';
import 'package:funsunfront/services/api_remit.dart';

import 'package:funsunfront/widgets/achievement_rate.dart';
import 'package:funsunfront/widgets/loading_circle.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
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
  late ProfileProvider _profileProvider;
  late FundingsProvider _fundingsProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    _fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);
    final Future<List<RemitModel>> remits = Remit.getRemit(id: id, page: '1');

    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    Future<void> refreshFunction() async {
      _fundingsProvider.getFundingDetail(id);
    }

    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshFunction,
        child: SafeArea(
          child: FutureBuilder(
            future: _fundingsProvider.fundingDetail,
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

                // print('펀딩에 등록된 시간 ${DateTime.parse(funding.expireOn)}');
                // print('현재 시간 ${DateTime.now()}');
                final bool isExpired =
                    DateTime.parse(funding.expireOn).isBefore(DateTime.now());
                final ex = DateTime.parse(funding.expireOn)
                    .difference(DateTime.now())
                    .toString();

                int tempDifference =
                    int.parse((ex.substring(0, ex.indexOf(':'))));

                final leftDays = tempDifference ~/ 24;
                //print('차이나는 날짜만 출력 : $leftDays');

                final leftHours = tempDifference - leftDays * 24;
                //print('차이나는 시간만 출력 : $leftHours');

                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              // 펀딩작성자의 프로필 사진, 닉네임
                              width: screenWidth * 0.8,
                              child: InkWell(
                                onTap: () async {
                                  // 다른 사람 펀딩이면 해당 유저의 프로필로 이동
                                  if (funding.author!['id'] !=
                                      _userProvider.user!.id) {
                                    await _profileProvider
                                        .updateProfile(funding.author!['id']);
                                    //해당 유저의 펀딩
                                    _fundingsProvider.getMyfundings(
                                        funding.author!['id'], 1);
                                    if (context.mounted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UserScreen(
                                              id: funding.author!['id']),
                                        ),
                                      );
                                    }
                                  } else // 내 펀딩이면 마이페이지로 이동
                                  {
                                    if (context.mounted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyScreen()),
                                      );
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 17,
                                            backgroundImage: funding
                                                        .author!['image'] !=
                                                    null
                                                ? NetworkImage(
                                                    '$baseurl${funding.author!['image']}',
                                                  )
                                                : Image.asset(
                                                        'assets/images/default_profile.jpg')
                                                    .image,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            funding.author!['username'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      (funding.public!)
                                          ? const Text('')
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.lock,
                                                    size: 15,
                                                    color: Colors.grey[700],
                                                  ),
                                                  const Text(' 친구공개'),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Stack(
                              children: [
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
                                (isExpired)
                                    ? Container(
                                        alignment: Alignment.center,
                                        width: screenWidth * 0.8,
                                        height: screenWidth * 0.12,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30)),
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.7),
                                        ),
                                        child: const Text(
                                          '만료된 펀딩입니다.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ],
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.1),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        FundingEditScreen(
                                                  origin: funding,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Row(
                                            children: [
                                              Icon(Icons.edit, size: 23),
                                              SizedBox(width: 5),
                                              Text('수정하기'),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        FundingDeleteScreen(
                                                            funding),
                                              ),
                                            );
                                          },
                                          child: const Row(
                                            children: [
                                              Text('삭제하기'),
                                              SizedBox(width: 5),
                                              Icon(Icons.delete, size: 23),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
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
                        const SizedBox(
                          height: 20,
                        ),
                        (leftDays > 0 || leftHours > 0)
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: GestureDetector(
                                  // 펀딩하기 버튼
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RemitScreen(
                                                targetFunding: funding,
                                              )),
                                    );
                                  },
                                  child: const PinkBtn(
                                    btnTxt: '서포트하기',
                                  ),
                                ))
                            : const SizedBox(),
                        (funding.author!['id'] == _userProvider.user!.id)
                            ? const SizedBox()
                            : ReportIcon(funding.id!, 'funding', ''),
                        Column(
                          children: [
                            Transform.translate(
                              offset: const Offset(0, 15),
                              child: Transform.scale(
                                scale: 1.5,
                                child: Image.asset(
                                    'assets/images/pinkCircles.png'),
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

                                  return (remits.isEmpty)
                                      ? Container(
                                          color: const Color.fromARGB(
                                              255, 255, 159, 208),
                                          width: screenWidth,
                                          height: 80,
                                          child: const Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  '첫번째로 펀딩을 하고 축하메세지를 남겨보세요!',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ),
                                        )
                                      : Column(
                                          // 펀딩 축하메세지
                                          children: [
                                            for (final remit
                                                in remits) //listview 안쓰고 for문으로
                                              Container(
                                                color: const Color.fromARGB(
                                                    255, 255, 159, 208),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          screenWidth * 0.1,
                                                      vertical: 15),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                            // 각각 유저 프로필로 이동, profileProvider로 유저 정보 불러오기
                                                            onTap: () async {
                                                              if (_userProvider
                                                                      .user!
                                                                      .id ==
                                                                  remit.author
                                                                      .id) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            MyScreen(),
                                                                  ),
                                                                );
                                                              } else {
                                                                await _profileProvider
                                                                    .updateProfile(
                                                                        remit
                                                                            .author
                                                                            .id);
                                                                _fundingsProvider
                                                                    .getMyfundings(
                                                                        remit
                                                                            .author
                                                                            .id,
                                                                        1);
                                                                if (context
                                                                    .mounted) {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => UserScreen(
                                                                          id: remit
                                                                              .author
                                                                              .id),
                                                                    ),
                                                                  );
                                                                }
                                                              }
                                                            },
                                                            child: CircleAvatar(
                                                              radius:
                                                                  screenWidth *
                                                                      0.09,
                                                              backgroundImage: remit
                                                                          .author
                                                                          .image !=
                                                                      null
                                                                  ? NetworkImage(
                                                                      '$baseurl${remit.author.image}',
                                                                    )
                                                                  : Image.asset(
                                                                          'assets/images/default_profile.jpg')
                                                                      .image,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.02,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    screenWidth *
                                                                        0.6,
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
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    (remit.author.id.toString() ==
                                                                            _userProvider
                                                                                .user!.id)
                                                                        ? const SizedBox()
                                                                        : ReportIcon(
                                                                            remit.id.toString(),
                                                                            'remit',
                                                                            ''),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    screenWidth *
                                                                        0.6,
                                                                child: Text(
                                                                  remit.message,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  softWrap:
                                                                      true,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .visible,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 15),
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
                            (funding.review != null)
                                ? Stack(children: [
                                    Positioned(
                                        top: 10,
                                        child: Container(
                                          height: 100,
                                          width: screenWidth,
                                          color: const Color.fromARGB(
                                              255, 178, 159, 255),
                                        )),
                                    Column(
                                      children: [
                                        Container(
                                          color: const Color.fromARGB(
                                              255, 255, 159, 208),
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
                                          offset: const Offset(0, 0),
                                          child: Expanded(
                                            child: Container(
                                              color: const Color.fromARGB(
                                                  255, 178, 159, 255),
                                              width: screenWidth,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      '펀딩 후기',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        if (funding
                                                                .reviewImage !=
                                                            null)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.8,
                                                              height:
                                                                  screenWidth *
                                                                      0.8,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorDark
                                                                    .withOpacity(
                                                                        0.6),
                                                              ),
                                                              clipBehavior:
                                                                  Clip.hardEdge,
                                                              child:
                                                                  Image.network(
                                                                fit: BoxFit
                                                                    .cover,
                                                                '$baseurl${funding.reviewImage}',
                                                              ),
                                                            ),
                                                          ),
                                                        Container(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              178, 159, 255),
                                                          width: screenWidth,
                                                          child: Text(
                                                            funding.review!,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Transform.translate(
                                      offset: const Offset(0, 1000),
                                      child: Container(
                                        height: 50,
                                        color: const Color.fromARGB(
                                            255, 178, 159, 255),
                                      ),
                                    ),
                                  ])
                                : Column(
                                    children: [
                                      Container(
                                        color: const Color.fromARGB(
                                            255, 255, 159, 208),
                                        height: 150,
                                        child: (funding.author!['id'] ==
                                                _userProvider.user!.id)
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReviewScreen(
                                                        origin: funding,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Center(
                                                  child: PinkBtn(
                                                    btnTxt: '후기 작성하기',
                                                  ),
                                                ),
                                              )
                                            : Container(),
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
      ),
    );
  }
}
