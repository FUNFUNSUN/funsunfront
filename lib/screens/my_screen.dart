import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/screens/edit_screen.dart';
import 'package:funsunfront/screens/faq_screen.dart';
import 'package:funsunfront/widgets/profile.dart';
import 'package:provider/provider.dart';

import '../models/funding_model.dart';
import '../provider/user_provider.dart';
import '../services/api_funding.dart';
import '../widgets/fundingcard_horizon.dart';

class MyScreen extends StatelessWidget {
  MyScreen({
    super.key,
  });

  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: true);
    final Future<List<FundingModel>> fundings =
        Funding.getJoinedFunding(page: '1');

    final Future<List<FundingModel>> myfundings =
        Funding.getUserFunding(page: '1', id: _userProvider.user!.id);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            ///////////////////////유저 프로필
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Profile(
                    userimg: _userProvider.user!.image,
                    userName: _userProvider.user!.username,
                    following: _userProvider.user!.followee!,
                    follower: _userProvider.user!.follower!,
                    //이렇게 하는게 맞는지 정확히는 모르겠음
                  ),
                  ////////////////////////유저 프로필 END
                  const SizedBox(
                    height: 10,
                  ),
                  /////////////////////////내펀딩만들기 | 팔로우 버튼
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditScreen()),
                      );
                      print('펀딩작성페이지라우팅');
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
                            color: Colors.white, fontWeight: FontWeight.w600),
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
                    sizeX: sizeX,
                    fundings: myfundings,
                    title: '내 펀딩',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 35),
                  child: FundingCardHorizon(
                      sizeX: sizeX, fundings: myfundings, title: '서포트한 펀딩'),
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
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: .5,
                  width: sizeX,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        logout();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.exit_to_app_rounded,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '로그아웃',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(right: 30),
                        child: const Row(
                          children: [
                            Text(
                              '회원탈퇴',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
  }
}
