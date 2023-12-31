import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/models/account_model.dart';
import 'package:funsunfront/screens/all_fundings_screen.dart';
import 'package:funsunfront/screens/dropout_confirm_screen.dart';
import 'package:funsunfront/screens/funding_create_screen.dart';
import 'package:funsunfront/screens/faq_screen.dart';
import 'package:funsunfront/screens/profile_edit_screen.dart';
import 'package:funsunfront/widgets/profile.dart';
import 'package:provider/provider.dart';

import '../provider/fundings_provider.dart';
import '../provider/user_provider.dart';
import '../widgets/fundingcard_horizon.dart';

// ignore: must_be_immutable
class MyScreen extends StatelessWidget {
  MyScreen({
    super.key,
  });

  late FundingsProvider _fundingsProvider;
  late UserProvider _userProvider;

  Future<void> refreshFunction() async {
    _userProvider.updateUser();
    _fundingsProvider.refreshAllFundings(_userProvider.user!.id);
    print('refreshed');
  }

  @override
  Widget build(BuildContext context) {
    _fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);
    _userProvider = Provider.of<UserProvider>(context, listen: true);
    AccountModel user = _userProvider.user!;
    final sizeX = MediaQuery.of(context).size.width;
    int sunCnt = 0;
    // final sizeY = MediaQuery.of(context).size.height;

    void logout() async {
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'accessToken');
      await storage.delete(key: 'refreshToken');
      _userProvider.setLogin("");
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshFunction,
        child: LayoutBuilder(
          builder: ((context, constraints) {
            return SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    ///////////////////////유저 프로필
                    Padding(
                      padding: EdgeInsets.all(sizeX * 0.07),
                      child: Column(
                        children: [
                          Stack(children: [
                            Profile(
                              //프로필
                              userimg: _userProvider.user!.image,
                              userName: _userProvider.user!.username,
                              following: _userProvider.user!.followee,
                              follower: _userProvider.user!.follower,
                              user: _userProvider.user!,
                            ),
                            Positioned(
                              //프로필 수정버튼
                              bottom: sizeX * 0.015,
                              left: sizeX * 0.18,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileEditScreen(
                                              origin: _userProvider.user!,
                                            )),
                                  );
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                          color: Color.fromARGB(
                                              137, 173, 173, 173),
                                          blurRadius: .6,
                                          offset: Offset(0.0, 0.75))
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.settings,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ]),

                          ////////////////////////유저 프로필 END
                          const SizedBox(
                            height: 20,
                          ),
                          /////////////////////////내펀딩만들기 | 팔로우 버튼
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
                                                ),
                                              ),
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
                            child: Container(
                              alignment: Alignment.center,
                              width: sizeX,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: const Text(
                                '내 펀딩 만들기',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //////////////////////// 버튼 END

                    //////////////////////// 펀딩 리스트
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: FundingCardHorizon(
                            fundingType: 'myFunding',
                            routeFunction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllFundingsScreen(
                                    title: '내 펀딩',
                                    fundingType: 'myFunding',
                                    page: '1',
                                    uid: _userProvider.user!.id,
                                  ),
                                ),
                              );
                            },
                            sizeX: sizeX,
                            title: '내 펀딩',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 35),
                          child: FundingCardHorizon(
                            fundingType: 'mySupport',
                            routeFunction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AllFundingsScreen(
                                    title: '서포트한 펀딩',
                                    fundingType: 'mySupport',
                                    page: '1',
                                  ),
                                ),
                              );
                            },
                            sizeX: sizeX,
                            title: '서포트한 펀딩',
                          ),
                        ),
                      ],
                    ),

                    /////////////////////////// 펀딩리스트END
                    /////////////////////////// FAQ, 로그아웃, 회원탈퇴
                    Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FaqScreen()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 30),
                            child: const Row(
                              children: [
                                Icon(Icons.help_outline_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'FAQ',
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          height: .5,
                          width: sizeX,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            //로그아웃 및 탈퇴
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  logout();
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      size: 15,
                                      Icons.exit_to_app_rounded,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '로그아웃',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onLongPress: () {
                                  if (sunCnt == 5) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: sizeX * 0.9,
                                                child: Image.asset(
                                                  'assets/images/kitty_thumbsup.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const Text(
                                                '원윤선.. 그녀는 2주사이\n미친 성장을 보여주었다.\n나는 그대가 자랑스럽다.',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                },
                                child: IconButton(
                                    onPressed: () {
                                      if (sunCnt < 5) {
                                        sunCnt++;
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.question_mark,
                                      size: 15,
                                      color: Colors.white,
                                    )),
                              ),
                              InkWell(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DropOutConfirmScreen()),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      '회원탈퇴',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                /////////////////////////// FAQ, 로그아웃, 회원탈퇴 END
              ),
            );
          }),
        ),
      ),
    );
  }
}
