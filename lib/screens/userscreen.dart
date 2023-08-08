import 'package:flutter/material.dart';
import 'package:funsunfront/provider/profile_provider.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/services/api_follow.dart';
import 'package:funsunfront/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../provider/fundings_provider.dart';
import '../widgets/fundingcard_horizon.dart';
import '../widgets/profile.dart';
import '../widgets/report_icon.dart';

class UserScreen extends StatelessWidget {
  final String id;
  UserScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  late UserProvider userProvider;
  late ProfileProvider profileProvider;
  late FundingsProvider fundingsProvider;

  Future<void> refreshFunction() async {
    userProvider.updateUser();
    profileProvider.updateProfile(profileProvider.profile!.id);
    fundingsProvider.getMyfundings(profileProvider.profile!.id, 1);
    print('refreshed');
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: true);
    profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);

    final sizeX = MediaQuery.of(context).size.width;
    // final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: const BtmNavBarWidget(),
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
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ReportIcon(
                                profileProvider.profile!.id, 'account', ''),
                          ],
                        ),
                        Profile(
                          userimg: profileProvider.profile?.image,
                          userName: profileProvider.profile!.username,
                          following: profileProvider.profile!.followee,
                          follower: profileProvider.profile!.follower,
                          uid: profileProvider.profile!.id,
                        ),

                        ////////////////////////유저 프로필 END
                        const SizedBox(
                          height: 20,
                        ),
                        /////////////////////////내펀딩만들기 | 팔로우 버튼
                        FollowBtn(
                          uid: profileProvider.profile!.id,
                          currentuid: userProvider.user!.id,
                          sizeX: sizeX,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FundingCardHorizon(
                          fundingType: 'userFunding',
                          sizeX: sizeX,
                          title: '${profileProvider.profile!.username}의 펀딩',
                        ),
                        /////////////////////////// 펀딩리스트END
                        /////////////////////////// FAQ, 로그아웃, 회원탈퇴

                        const SizedBox(
                          height: 40,
                        )
                      ]),
                    ),
                    //////////////////////// 버튼 END

                    //////////////////////// 펀딩 리스트
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

class FollowBtn extends StatefulWidget {
  const FollowBtn({
    super.key,
    required this.uid,
    required this.currentuid,
    required this.sizeX,
  });

  final String uid;
  final String currentuid;
  final double sizeX;

  @override
  State<FollowBtn> createState() => _FollowBtnState();
}

class _FollowBtnState extends State<FollowBtn> {
  late Future<bool> isFollowing;
  late ProfileProvider profileProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    isFollowing =
        Follow.isFollowing(uid: widget.uid, currentuid: widget.currentuid);
  }

  void handdleFollow(bool status) async {
    if (status) {
      await Follow.delFollow(uid: widget.uid);
      profileProvider.decreaseFollow();
    } else {
      await Follow.postFollow(uid: widget.uid);
      profileProvider.increaseFollow();
    }

    setState(() {
      isFollowing =
          Follow.isFollowing(uid: widget.uid, currentuid: widget.currentuid);
    });
    userProvider.updateUser();
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);

    return FutureBuilder(
        future: isFollowing,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return InkWell(
              onTap: () {
                handdleFollow(snapshot.data!);
                print('팔로우버튼');
              },
              child: Container(
                alignment: Alignment.center,
                width: widget.sizeX,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColorLight.withOpacity(0.4),
                ),
                child: Text(
                  snapshot.data! ? '팔로우 취소' : '팔로우하기',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
            );
          }
          return const SizedBox();
        });
  }
}
