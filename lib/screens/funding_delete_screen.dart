// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:funsunfront/models/funding_model.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/services/api_funding.dart';
import 'package:funsunfront/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../widgets/achievement_rate.dart';

class FundingDeleteScreen extends StatelessWidget {
  FundingDeleteScreen(this.funding, {Key? key}) : super(key: key);

  FundingModel funding;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    FundingsProvider fundingsProvider =
        Provider.of<FundingsProvider>(context, listen: false);

    final ex =
        DateTime.parse(funding.expireOn).difference(DateTime.now()).toString();

    int tempDifference = int.parse((ex.substring(0, ex.indexOf(':'))));

    final leftDays = tempDifference ~/ 24;
    //print('차이나는 날짜만 출력 : $leftDays');

    final leftHours = tempDifference - leftDays * 24;
    //print('차이나는 시간만 출력 : $leftHours');
    return Scaffold(
      appBar: const FunSunAppBar(
          title: '펀딩 삭제 페이지입니다.', content: '삭제하시기 전, 내용을 잘 읽어주세요.'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 30.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('펀딩을 삭제하게 될 경우, 되돌릴 수 없으며, 정산이 어려울 수 있습니다.  '),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '삭제할 게시글 : ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: screenWidth * 0.9,
                  child: Text(
                    funding.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
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
                                        fundingsProvider.refreshAllFundings(
                                            funding.author!['id'].toString());

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
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
