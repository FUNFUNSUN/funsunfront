// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/screens/all_fundings_screen.dart';
import 'package:funsunfront/screens/profile_edit_screen.dart';
import 'package:funsunfront/widgets/fundingcard_horizon.dart';
import 'package:provider/provider.dart';
import '../models/account_model.dart';
import '../provider/fundings_provider.dart';
import 'funding_create_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  late FundingsProvider fundingsProvider;
  final List<String> devIdList = [
    '2943720963', //정현
    '2943717833', //후추
    '2920117956', //윤선
    '2919921020', //상규
  ];

  Future<void> refreshFunction() async {
    fundingsProvider.getFriendFundings(1);
    print('refreshed');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);
    AccountModel user = Provider.of<UserProvider>(context, listen: false).user!;
    int cnt = 0;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
        body: RefreshIndicator(
          onRefresh: refreshFunction,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          '마음을 모아 펀딩해보세요',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '소중한 순간을 더욱 특별하게, 모두 함께 펀딩!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              if (cnt < 6) {
                                cnt++;
                              }
                            },
                            child: Image.asset(
                              'assets/images/giftWithCal.png',
                              width: 250,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            if (user.bankAccount == '' ||
                                user.bankAccount == null ||
                                user.bankAccount == ' ') {
                              showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    title: const Text('계좌를 등록해주세요'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileEditScreen(
                                                      origin: user,
                                                    )),
                                          );
                                        },
                                        child: const Text('프로필 수정하러 가기'),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FundingCreateScreen()),
                              );
                            }
                          },
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              width: screenWidth * 0.4,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: const Text(
                                '펀딩 등록하러 가기',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ]),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 20,
                          left: screenWidth * 0.07,
                          right: screenWidth * 0.07),
                      width: screenWidth,
                      height: screenHeight * 0.6, //0.64였음
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'FunSun과 함께 더 특별한 선물을',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xffF5F7FB)),
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2,
                                child: Image.asset(
                                    'assets/images/three_gifts.png'),
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              SizedBox(
                                width: screenWidth - screenWidth * 0.4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '함께 모여 특별한 선물 준비',
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Text(
                                      '소중한 사람들과 함께 특별한 선물을 준비할 수 있도록 도와줍니다.',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xffF5F7FB)),
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2,
                                child:
                                    Image.asset('assets/images/touch_coin.png'),
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              SizedBox(
                                width: screenWidth - screenWidth * 0.4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '실시간 상태 확인',
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Text(
                                        style: TextStyle(fontSize: 12),
                                        '펀딩 진행 상태와 친구들의 서포트를 실시간으로 확인하세요.'),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xffF5F7FB)),
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2,
                                child: Image.asset(
                                    'assets/images/hands_w_heart.png'),
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              SizedBox(
                                width: screenWidth - screenWidth * 0.4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '감동의 공유',
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Text(
                                        style: TextStyle(fontSize: 12),
                                        '펀딩이 완료되면 특별한 순간을 후기로 공유할 수 있습니다. \n더 많은 이들에게 감동을 전하세요!'),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 55,
                          ),
                          InkWell(
                            //easterEgg
                            onLongPress: () {
                              if (cnt > 5) {
                                if (devIdList.contains(user.id)) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Image.network(
                                                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fknowyourmeme.com%2Fmemes%2Fcrying-cat&psig=AOvVaw04_u_EDplbWjFMfAFWIEFW&ust=1692844015492000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCNDoxcPd8YADFQAAAAAdAAAAABAE',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const Text(
                                              '원윤선 미워.',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // 다이얼로그 닫기
                                            },
                                            child: const Text('닫기'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                '펀딩의 기쁨을 함께 나눠보세요!',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.white,
                      child: FundingCardHorizon(
                          fundingType: 'friendFunding',
                          routeFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AllFundingsScreen(
                                  title: '친구들의 펀딩',
                                  fundingType: 'friendFunding',
                                  page: '1',
                                ),
                              ),
                            );
                          },
                          sizeX: screenWidth,
                          title: '     친구들의 펀딩'),
                    ),
                    Container(
                      color: Colors.white,
                      height: 20,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (user.bankAccount == '' ||
                        user.bankAccount == null ||
                        user.bankAccount == ' ') {
                      showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: const Text('계좌를 등록해주세요'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileEditScreen(
                                              origin: user,
                                            )),
                                  );
                                },
                                child: const Text('프로필 수정하러 가기'),
                              ),
                            ],
                          );
                        }),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FundingCreateScreen()),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      '펀딩 등록하러 가기',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
