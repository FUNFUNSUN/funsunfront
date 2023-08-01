import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/screens/faq_screen.dart';
import 'package:funsunfront/widgets/profile.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../widgets/fundingcard_horizon.dart';

class UserScreen extends StatelessWidget {
  UserScreen({
    super.key,
  });
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: true);
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    bool isUser = true;

    void logout() async {
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'accessToken');
      await storage.delete(key: 'refreshToken');
      _userProvider.setLogin("");
    }

    List<String> imgUrls = [];
    imgUrls.add(
        'https://flexible.img.hani.co.kr/flexible/normal/970/970/imgdb/original/2023/0619/20230619501341.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnSNkiSUcQ1o4jzsNDFSNYE1Bt3xmRZK3joQ&usqp=CAU');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');

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
                  (isUser == true)
                      ? InkWell(
                          onTap: () {
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            print('팔로우버튼');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: sizeX,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .primaryColorLight
                                  .withOpacity(0.4),
                            ),
                            child: const Text(
                              '팔로우하기',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            //////////////////////// 버튼 END

            //////////////////////// 펀딩 리스트
            (isUser == true)
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: FundingCardHorizon(
                          sizeX: sizeX,
                          imgUrls: imgUrls,
                          title: '내 펀딩',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 35),
                        child: FundingCardHorizon(
                          sizeX: sizeX,
                          imgUrls: imgUrls,
                          title: '서포트한 펀딩',
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: FundingCardHorizon(
                      sizeX: sizeX,
                      imgUrls: imgUrls,
                      title: '내 펀딩',
                    ),
                  ),
            /////////////////////////// 펀딩리스트END
            /////////////////////////// FAQ, 로그아웃, 회원탈퇴
            (isUser == true)
                ? Column(
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
                  )
                : const SizedBox(
                    height: 40,
                  )
          ],
        ),
        /////////////////////////// FAQ, 로그아웃, 회원탈퇴 END
      ),
    );
  }
}
