import 'package:flutter/material.dart';
import 'package:funsunfront/models/account_model.dart';
import '../services/api_account.dart';

class ApiTest extends StatelessWidget {
  const ApiTest({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<AccountModel> testProfile = Account.getProfile('admin');

    return Scaffold(
      body: Center(
        child: FutureBuilder<AccountModel>(
          future: testProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 데이터를 불러오는 동안 로딩 표시
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // 오류 표시
              return Text('오류: ${snapshot.error}');
            } else {
              // 로딩 끝났으면 표시가능
              final profile = snapshot.data;
              profile!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ID: ${profile.id}'),
                  Text('Email: ${profile.email}'),
                  Text('생년월일: ${profile.birthday}'),
                  Text('사용자명: ${profile.username}'),
                  Text('성별: ${profile.gender}'),
                  Text('팔로워: ${profile.follower ?? 0}'),
                  Text('팔로잉: ${profile.followee ?? 0}'),
                  Image.network(
                      'http://projectsekai.kro.kr:5000${profile.image}'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
