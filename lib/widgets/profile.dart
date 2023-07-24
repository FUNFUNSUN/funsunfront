import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String userName;
  final int following, follower;

  const Profile(
      {super.key,
      required this.userName,
      required this.following,
      required this.follower});

  @override
  Widget build(BuildContext context) {
    String followingStr = following.toString();
    String followerStr = follower.toString();
    return Row(
      children: [
        const Icon(
          Icons.circle,
          color: Colors.black,
          size: 125,
        ),
        const SizedBox(
          width: 15,
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
          ],
        ),
      ],
    );
  }
}
