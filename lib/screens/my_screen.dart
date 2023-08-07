import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/screens/dropout_confirm_screen.dart';
import 'package:funsunfront/screens/funding_create_screen.dart';
import 'package:funsunfront/screens/faq_screen.dart';
import 'package:funsunfront/screens/profile_edit_screen.dart';
import 'package:funsunfront/widgets/profile.dart';
import 'package:provider/provider.dart';

import '../provider/fundings_provider.dart';
import '../provider/profile_provider.dart';
import '../provider/user_provider.dart';
import '../widgets/fundingcard_horizon.dart';
import 'myfunding_screen.dart';
import 'mysupport_screen.dart';

// ignore: must_be_immutable
class MyScreen extends StatelessWidget {
  MyScreen({
    super.key,
  });

  late FundingsProvider _fundingsProvider;
  late UserProvider _userProvider;
  late ProfileProvider _profileProvider;

  Future<void> refreshFunction() async {
    await _profileProvider
        .updateProfile(_userProvider.user!.id); // 팔로워 팔로잉 위젯 때문에 profile에 세팅
    _userProvider.updateUser();
    _fundingsProvider.refreshAllFundings(_userProvider.user!.id);
    print('refreshed');
  }

  @override
  Widget build(BuildContext context) {
    _fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);
    _userProvider = Provider.of<UserProvider>(context, listen: true);
    _profileProvider = Provider.of<ProfileProvider>(context, listen: true);
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
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Stack(children: [
                            Profile(
                              //프로필
                              userimg: _userProvider.user!.image,
                              userName: _userProvider.user!.username,
                              following: _userProvider.user!.followee,
                              follower: _userProvider.user!.follower,
                              // 업로드한 이미지 있으면,
                              //uploadedImage: _userProvider.profileImage,
                              // 팔로워 팔로잉 위젯 때문에 profile에 세팅
                              uid: _userProvider.user!.id,
                            ),
                            Positioned(
                              //프로필 수정버튼
                              bottom: 10,
                              left: 90,
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
                                  width: 20,
                                  height: 20,
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
                                    size: 15,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FundingCreateScreen()),
                              );
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
                                  builder: (context) => MyFundingScreen(
                                    page: '1',
                                  ),
                                ),
                              );
                            },
                            sizeX: sizeX,
                            // fetchFunding: (page) => Funding.getUserFunding(
                            //     page: page, id: _userProvider.user!.id),
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
                                  //그냥 mySupportScreen 넣어도 되는게 fetchFunding따로 넣어줌
                                  builder: (context) => const MySupportScreen(
                                    page: '1',
                                  ),
                                ),
                              );
                            },
                            sizeX: sizeX,
                            // fetchFunding: (page) =>
                            //     Funding.getJoinedFunding(page: page),
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
                              IconButton(
                                  onPressed: () {
                                    if (sunCnt < 4) {
                                      sunCnt++;
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: sizeX * 0.7,
                                                  child: Image.network(
                                                      'https://blogpfthumb-phinf.pstatic.net/MjAyMzAxMTdfMjIx/MDAxNjczOTQ1NDc2MzE5.bWG6m1D4IPYP9Vt6UWjzHB5N49V6OR4tYAsBzto7-rkg.R6Vff_l6qAilZIpiFd_uIe-2fj6z92zMXrSTcPwxLlog.PNG.7116won/profileImage.png'),
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
                                  icon: const Icon(
                                    Icons.question_mark,
                                    size: 15,
                                    color: Colors.white,
                                  )),
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
