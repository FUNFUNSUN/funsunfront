import 'package:flutter/material.dart';
import 'package:funsunfront/widgets/profile.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const Profile(
                  userName: '안녕',
                  following: 12,
                  follower: 10,
                  //이렇게 하는게 맞는지 정확히는 모르겠음
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFF80C0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
