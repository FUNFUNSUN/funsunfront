import 'package:flutter/material.dart';
import 'package:funsunfront/models/account_model.dart';
import 'package:funsunfront/services/api_funding.dart';
import 'package:funsunfront/widgets/loading_circle.dart';

import '../models/funding_model.dart';
import '../services/api_account.dart';
import '../widgets/fundingcard_horizon.dart';
import '../widgets/profile.dart';

class UserScreen extends StatelessWidget {
  final String id;
  const UserScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<AccountModel> account = Account.getProfile(id, 2);
    final Future<List<FundingModel>> userfundings =
        Funding.getUserFunding('1', id, 2);

    final sizeX = MediaQuery.of(context).size.width;
    // final sizeY = MediaQuery.of(context).size.height;

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
              child: FutureBuilder(
                  future: account,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // 데이터를 불러오는 동안 로딩 표시
                      return const LoadingCircle();
                    } else if (snapshot.hasError) {
                      // 오류 표시
                      return Text('오류: ${snapshot.error}');
                    } else {
                      final user = snapshot.data;
                      user!;
                      return Column(children: [
                        Profile(
                            userName: user.username,
                            following: user.followee!,
                            follower: user.follower!),

                        ////////////////////////유저 프로필 END
                        const SizedBox(
                          height: 10,
                        ),
                        /////////////////////////내펀딩만들기 | 팔로우 버튼
                        InkWell(
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
                        const SizedBox(
                          height: 30,
                        ),
                        FundingCardHorizon(
                          sizeX: sizeX,
                          fundings: userfundings,
                          title: '${user.username}의 펀딩',
                        ),
                        /////////////////////////// 펀딩리스트END
                        /////////////////////////// FAQ, 로그아웃, 회원탈퇴

                        const SizedBox(
                          height: 40,
                        )
                      ]);
                    }
                  }),
            ),
            //////////////////////// 버튼 END

            //////////////////////// 펀딩 리스트
          ],
        ),
        /////////////////////////// FAQ, 로그아웃, 회원탈퇴 END
      ),
    );
  }
}
