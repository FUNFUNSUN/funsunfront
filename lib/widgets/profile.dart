import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../screens/follow_screen.dart';

class Profile extends StatelessWidget {
  final String userName, uid;
  final int following, follower;
  final String? userimg;
  final File? uploadedImage;

  const Profile(
      {super.key,
      required this.userName,
      required this.following,
      required this.follower,
      this.userimg,
      this.uploadedImage,
      required this.uid});

  @override
  Widget build(BuildContext context) {
    String followingStr = following.toString();
    String followerStr = follower.toString();
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    FundingsProvider fundingsProvider =
        Provider.of<FundingsProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    const String baseUrl = 'http://projectsekai.kro.kr:5000/';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        (userimg != null)
            ? InkWell(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: SizedBox(
                          width: screenWidth * 0.7,
                          height: screenWidth * 0.7,
                          child: Image.network('$baseUrl$userimg'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // 다이얼로그 닫기
                            },
                            child: const Text('닫기'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: CircleAvatar(
                    //유저 프로필 이미지
                    radius: screenWidth * 0.12,
                    backgroundImage: NetworkImage('$baseUrl$userimg')),
              )
            : CircleAvatar(
                //디폴트 프로필 이미지
                radius: screenWidth * 0.12,
                backgroundImage:
                    const AssetImage('assets/images/default_profile.jpg')),
        SizedBox(
          width: screenWidth - screenWidth * 0.38,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$userName 님',
                  style: const TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          // 팔로우 팔로워를 위해 profileProvider에 uid 넘겨주기
                          await profileProvider.updateProfile(uid);
                          fundingsProvider.getMyfundings(
                              profileProvider.profile!.id, 1);
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FollowScreen(
                                  initIndex: 0,
                                ),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child: Text('팔로워 $followerStr명',
                              style: const TextStyle(fontSize: 15)),
                        )),
                    Text(
                      '|',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // 팔로우 팔로워를 위해 profileProvider에 uid 넘겨주기
                        await profileProvider.updateProfile(uid);
                        fundingsProvider.getMyfundings(
                            profileProvider.profile!.id, 1);

                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FollowScreen(
                                initIndex: 1,
                              ),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                        child: Text('팔로잉 $followingStr명',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
