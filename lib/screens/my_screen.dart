import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/screens/dropout_confirm_screen.dart';
import 'package:funsunfront/screens/funding_create_screen.dart';
import 'package:funsunfront/screens/faq_screen.dart';
import 'package:funsunfront/screens/profile_edit_screen.dart';
import 'package:funsunfront/widgets/profile.dart';
import 'package:provider/provider.dart';

import '../provider/fundings_provider.dart';
import '../provider/user_provider.dart';
import '../services/api_funding.dart';
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

  Future<void> refreshFunction() async {
    _userProvider.updateUser();
    _fundingsProvider.refreshAllFundings(_userProvider.user!.id);
    print('done');
  }

  @override
  Widget build(BuildContext context) {
    _fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);
    _userProvider = Provider.of<UserProvider>(context, listen: true);

    final sizeX = MediaQuery.of(context).size.width;
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
                              uploadedImage: _userProvider.profileImage,
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
                            routeFunction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyFundingScreen(
                                          page: '1',
                                        )),
                              );
                            },
                            sizeX: sizeX,
                            //fundings: fundingsProvider.myFundings!,
                            fetchFunding: (page) => Funding.getUserFunding(
                                page: page, id: _userProvider.user!.id),
                            title: '내 펀딩',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 35),
                          child: FundingCardHorizon(
                            routeFunction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MySupportScreen(
                                          page: '1',
                                        )),
                              );
                            },
                            sizeX: sizeX,
                            fetchFunding: (page) =>
                                Funding.getJoinedFunding(page: page),
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
