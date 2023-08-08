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
      children: [
        (uploadedImage == null)
            ? (userimg != null)
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
                        radius: 55,
                        backgroundImage: NetworkImage('$baseUrl$userimg')),
                  )
                : const CircleAvatar(
                    //디폴트 프로필 이미지
                    radius: 55,
                    backgroundImage:
                        AssetImage('assets/images/default_profile.jpg'))
            : CircleAvatar(
                //업로드한 프로필 이미지(있으면)
                radius: 60,
                backgroundImage: FileImage(uploadedImage!)),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$userName님',
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 8,
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
                    child: Text('팔로워 $followerStr명',
                        style: const TextStyle(fontSize: 12))),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '|',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                const SizedBox(
                  width: 20,
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
                  child: Text('팔로잉 $followingStr명',
                      style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
