import 'package:flutter/material.dart';
import 'package:funsunfront/models/account_model.dart';
import 'package:funsunfront/models/funding_model.dart';
import '../services/api_account.dart';
import '../services/api_funding.dart';

class ApiTest extends StatelessWidget {
  const ApiTest({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<AccountModel> testProfile = Account.getProfile('admin', false);
    final Future<FundingModel> testFunding = Funding.getFunding('1');
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FutureBuilder<AccountModel>(
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
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  );
                }
              },
            ),
            FutureBuilder<FundingModel>(
              future: testFunding,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 데이터를 불러오는 동안 로딩 표시
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // 오류 표시
                  return Text('오류: ${snapshot.error}');
                } else {
                  // 로딩 끝났으면 표시가능
                  final funding = snapshot.data;
                  funding!;
                  return Text(funding.title);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
