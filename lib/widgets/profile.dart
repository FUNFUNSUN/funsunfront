import 'dart:io';

import 'package:flutter/material.dart';

import '../screens/followTest.dart';

class Profile extends StatelessWidget {
  final String userName;
  final int following, follower;
  final String? userimg;
  final File? uploadedImage;

  const Profile(
      {super.key,
      required this.userName,
      required this.following,
      required this.follower,
      this.userimg,
      this.uploadedImage});

  @override
  Widget build(BuildContext context) {
    String followingStr = following.toString();
    String followerStr = follower.toString();

    const String baseUrl = 'http://projectsekai.kro.kr:5000/';
    return Row(
      children: [
        (uploadedImage == null)
            ? (userimg != null)
                ? CircleAvatar(
                    //유저 프로필 이미지
                    radius: 60,
                    backgroundImage: NetworkImage('$baseUrl$userimg'))
                : const CircleAvatar(
                    //디폴트 프로필 이미지
                    radius: 60,
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
              style: const TextStyle(fontSize: 20),
            ),
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FollowTest(
                                  initIndex: 0,
                                )),
                      );
                    },
                    child: Text('팔로워 $followerStr명')),
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FollowTest(
                                  initIndex: 1,
                                )),
                      );
                    },
                    child: Text('팔로잉 $followingStr명')),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
