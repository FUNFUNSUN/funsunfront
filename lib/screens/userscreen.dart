import 'package:flutter/material.dart';
import 'package:funsunfront/models/account_model.dart';
import 'package:funsunfront/provider/profile_provider.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/services/api_follow.dart';
import 'package:funsunfront/services/api_funding.dart';
import 'package:funsunfront/widgets/loading_circle.dart';
import 'package:provider/provider.dart';

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
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);

    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: true);

    final Future<AccountModel> account = User.getProfile(uid: id);

    final Future<List<FundingModel>> userfundings =
        Funding.getUserFunding(page: '1', id: id);

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
                            userimg: profileProvider.profile?.image,
                            userName: profileProvider.profile!.username,
                            following: profileProvider.profile!.followee!,
                            follower: profileProvider.profile!.follower!),

                        ////////////////////////유저 프로필 END
                        const SizedBox(
                          height: 10,
                        ),
                        /////////////////////////내펀딩만들기 | 팔로우 버튼
                        FollowBtn(
                            uid: profileProvider.profile!.id,
                            currentuid: userProvider.user!.id,
                            sizeX: sizeX),
                        const SizedBox(
                          height: 30,
                        ),
                        FundingCardHorizon(
                          sizeX: sizeX,
                          fundings: userfundings,
                          title: '${profileProvider.profile!.username}의 펀딩',
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFollowing =
        Follow.isFollowing(uid: widget.uid, currentuid: widget.currentuid);
  }

  void handdleFollow(bool status) async {
    status
        ? await Follow.delFollow(uid: widget.uid)
        : await Follow.postFollow(uid: widget.uid);

    setState(() {
      isFollowing =
          Follow.isFollowing(uid: widget.uid, currentuid: widget.currentuid);
    });
    profileProvider.updateProfile(profileProvider.profile!.id);
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

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
