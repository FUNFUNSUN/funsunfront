import 'package:flutter/material.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/widgets/fundingcard_horizon.dart';
import 'package:provider/provider.dart';

import 'funding_create_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _list = ['a', 'b', 'c'];
  //TODO : Fix hardcoding
  late FundingsProvider fundingsProvider;
  late UserProvider userProvider;

  Future<void> refreshFunction() async {
    userProvider.updateUser();
    fundingsProvider.refreshAllFundings(userProvider.user!.id);
    print('done');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
      body: RefreshIndicator(
        onRefresh: refreshFunction,
        child: LayoutBuilder(
          builder: ((context, constraints) {
            return SingleChildScrollView(
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
                            child: Image.asset(
                              'assets/images/giftWithCal.png',
                              width: 250,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FundingCreateScreen()),
                              );
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
                        padding:
                            const EdgeInsets.only(top: 20, left: 30, right: 30),
                        width: screenWidth,
                        height: screenHeight * 0.64,
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
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(
                                      'assets/images/three_gifts.png'),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
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
                                      '소중한 사람들과 함께 특별한 선물을 \n준비할 수 있도록 도와줍니다.',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
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
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(
                                      'assets/images/touch_coin.png'),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
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
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(fontSize: 12),
                                        '펀딩 진행 상태를 실시간으로 확인하고\n모든 과정을 투명하게 관리하세요'),
                                  ],
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
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(
                                      'assets/images/hands_w_heart.png'),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
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
                                        '펀딩이 완료되면 특별한 순간을 \n후기로 공유할 수 있습니다\n더 많은 이들에게 감동을 전하세요!'),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Text(
                                '펀딩의 기쁨을 함께 나눠보세요!',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.8),
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
                            sizeX: screenWidth,
                            fundings: fundingsProvider.publicFundings!,
                            title: '     전체공개펀딩'),
                      ),
                      Container(
                        color: Colors.white,
                        height: 20,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FundingCreateScreen()),
                      );
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

              // Container(
              //   width: 400,
              //   height: 400,
              //   decoration: BoxDecoration(
              //       color: Theme.of(context)
              //           .primaryColorLight
              //           .withOpacity(0.5),
              //       borderRadius: BorderRadius.circular(20)),
              //   child: ListView.builder(
              //     itemCount: _list.length,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         title: Text(_list[index]),
              //       );
              //     },
              //   ),
              // ),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => FundingScreen(id: '41')),
              //       );
              //     },
              //     child: const Text(' 펀딩 임시 이동버튼')),
            );
          }),
        ),
      ),
    );
  }

  Future<void> refreshHomeScreen(
      FundingsProvider fundingsProvider, String uid) async {
    // TODO: 여기서 API이용 메소드 작성
    final newList = ['d', 'e', 'f'];
    setState(() {
      _list = [..._list, ...newList];
    });
    fundingsProvider.refreshAllFundings(uid);
  }
}
