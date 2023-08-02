import 'package:flutter/material.dart';

import '../screens/followTest.dart';

class Profile extends StatelessWidget {
  final String userName;
  final int following, follower;
  final String? userimg;

  const Profile(
      {super.key,
      required this.userName,
      required this.following,
      required this.follower,
      this.userimg});

  @override
  Widget build(BuildContext context) {
    String followingStr = following.toString();
    String followerStr = follower.toString();

    const String baseUrl = 'http://projectsekai.kro.kr:5000/';
    return Row(
      children: [
        (userimg != null)
            ? CircleAvatar(
                radius: 60, backgroundImage: NetworkImage('$baseUrl$userimg'))
            : const CircleAvatar(
                radius: 60,
                backgroundImage:
                    AssetImage('assets/images/default_profile.jpg')),
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FollowTest()),
                );
              },
              child: Row(
                children: [
                  Text('팔로워 $followerStr명'),
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
                  Text('팔로잉 $followingStr명'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
