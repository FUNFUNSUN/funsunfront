// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../provider/profile_provider.dart';
import '../services/api_funding.dart';
import '../widgets/achievement_rate.dart';
import 'funding_screen.dart';

class PreviewScreen extends StatelessWidget {
  Map<String, dynamic> temp;
  File? image;
  PreviewScreen(this.temp, this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    bool flag = true;

    // DateTime KoreaDateTime = DateTime.now().add(const Duration(hours: 9));
    //print('한국 시간 $KoreaDateTime');
    //print('펀딩시간 ${DateTime.parse(temp['expire_on'])}');

    final ex =
        DateTime.parse(temp['expire_on']).difference(DateTime.now()).toString();

    int tempDifference = int.parse((ex.substring(0, ex.indexOf(':'))));

    final leftDays = tempDifference ~/ 24;
    //print('차이나는 날짜만 출력 : $leftDays');

    final leftHours = tempDifference - leftDays * 24;
    //print('차이나는 시간만 출력 : $leftHours');

    //const String baseurl = 'http://projectsekai.kro.kr:5000/';
    FundingsProvider fundingsProvider =
        Provider.of<FundingsProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '펀딩 내용을 확인해주세요',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '업로드 전 미리 확인하는 페이지입니다.',
                  style: TextStyle(color: Color(0xff7D7D7D)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenWidth * 0.8,
                  height: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).primaryColorDark.withOpacity(0.6),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: (image != null)
                      ? Image(
                          image: FileImage(image!),
                          fit: BoxFit.cover,
                        )
                      : Image.asset('assets/images/default_funding.jpg',
                          fit: BoxFit.cover),
                ),
                const SizedBox(
                  height: 30,
                ),
                AchievementRate(
                  percent: 0,
                  date: leftDays,
                  hour: leftHours,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      temp['title'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      temp['content'],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: InkWell(
                    onTap: () async {
                      if (flag) {
                        // 실제로 펀딩 작성 버튼 누르면 실행되는 부분
                        flag = false;

                        // postResult에 API결과 담아주고
                        Map<String, dynamic> postResult =
                            await Funding.postFunding(
                                fundingData: temp, image: image);

                        if (context.mounted) {
                          // 펀딩 작성 후에는 맨 밑까지 터트리고 펀딩 화면으로 이동
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          // 팔로잉페이지 때문에 profileProvider에 내정보 넣어주고
                          profileProvider.setProfile(userProvider.user!);
                          // 내 펀딩 목록 리로딩
                          fundingsProvider.getMyfundings(
                              userProvider.user!.id, 1);
                          // 전체공개 펀딩 목록 리로딩
                          fundingsProvider.getPublicFundings(1);
                          // 펀딩 상세 페이지 리로딩
                          fundingsProvider
                              .getFundingDetail(postResult['id'].toString());

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FundingScreen(
                                    id: postResult['id'].toString())),
                          );
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      width: 400,
                      height: 50,
                      child: const Center(
                        child: Text(
                          '등록하기',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
