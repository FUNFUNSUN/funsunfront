import 'package:flutter/material.dart';
import 'package:funsunfront/models/funding_model.dart';
import 'package:funsunfront/services/api_funding.dart';

import '../widgets/achievement_rate.dart';

class FundingDeleteScreen extends StatelessWidget {
  FundingDeleteScreen(this.funding, {Key? key}) : super(key: key);

  FundingModel funding;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const String baseurl = 'http://projectsekai.kro.kr:5000/';

    final ex =
        DateTime.parse(funding.expireOn).difference(DateTime.now()).toString();

    int tempDifference = int.parse((ex.substring(0, ex.indexOf(':'))));

    final leftDays = tempDifference ~/ 24;
    //print('차이나는 날짜만 출력 : $leftDays');

    final leftHours = tempDifference - leftDays * 24;
    //print('차이나는 시간만 출력 : $leftHours');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                '펀딩 삭제 페이지입니다.',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                '펀딩을 삭제하기 전, 내용을 확인해주세요',
                style: TextStyle(color: Color(0xff7D7D7D)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const Text(
                    '펀딩을 삭제하게 될 경우, 되돌릴 수 없으며, 현재까지 모인 금액 또한 환불 받을 수 없습니다.  '),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '삭제할 게시글 : ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  funding.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
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
                child: (funding.image != null)
                    ? Image.network(
                        '$baseurl${funding.image}',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/default_funding.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              AchievementRate(
                percent: funding.currentAmount! / funding.goalAmount,
                date: leftDays > 0 ? leftDays : 0,
                hour: leftHours > 0 ? leftHours : 0,
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('정말 삭제하시겠습니까?'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    print('start');
                                    final res = await Funding.deleteFunding(
                                        id: funding.id.toString());
                                    if (res) {
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('삭제완료'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('닫기'))
                                                ],
                                              );
                                            });
                                      }
                                    }
                                  },
                                  child: const Text('확인')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('취소')),
                            ],
                          );
                        });
                  },
                  child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        width: 400,
                        height: 50,
                        child: const Center(
                          child: Text(
                            '삭제하기',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
