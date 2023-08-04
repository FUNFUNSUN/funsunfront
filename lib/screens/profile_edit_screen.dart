import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    const String baseUrl = 'http://projectsekai.kro.kr:5000/';
    _userProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                        color: Theme.of(context).primaryColor,
                        Icons.add_a_photo),
                  ),
                ],
              ),
              const Text(
                '프로필 수정페이지입니다.',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '수정할 항목들을 입력하세요.',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              (_userProvider.profileImage == null)
                  ? (_userProvider.profileImage != null)
                      ? CircleAvatar(
                          //유저 프로필 이미지
                          radius: 55,
                          backgroundImage: NetworkImage(
                              '$baseUrl$_userProvider.profileImage'))
                      : const CircleAvatar(
                          //디폴트 프로필 이미지
                          radius: 55,
                          backgroundImage:
                              AssetImage('assets/images/default_profile.jpg'))
                  : CircleAvatar(
                      //업로드한 프로필 이미지(있으면)
                      radius: 60,
                      backgroundImage: FileImage(_userProvider.profileImage!)),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
