import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/services/api_remit.dart';
import 'package:provider/provider.dart';

import '../models/funding_model.dart';
import '../widgets/kakao_pay.dart';

class RemitCheckScreen extends StatelessWidget {
  Map<String, dynamic> remitMap;
  final FundingModel targetFunding;
  RemitCheckScreen(this.remitMap, this.targetFunding, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    final screenWidth = MediaQuery.of(context).size.width;
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    final FundingsProvider fundingsProvider =
        Provider.of<FundingsProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                      color: Theme.of(context).primaryColor, Icons.arrow_back),
                ),
                const Text(
                  '작성한 내용을 확인해주세요',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '결제하기 전 확인하는 페이지입니다..',
                  style: TextStyle(color: Color(0xff7D7D7D)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: targetFunding.image != null
                          ? NetworkImage(
                              '$baseurl${targetFunding.image}',
                            )
                          : Image.asset('assets/images/default_funding.jpg')
                              .image,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    // Text(remitMap['funding'].toString()),

                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(targetFunding.title),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '내가 작성한 축하메세지',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const Text(
                  '축하메세지를 확인하세요.',
                  style: TextStyle(color: Color(0xff7D7D7D)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Theme.of(context).primaryColorLight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: userProvider.user!.image != null
                                  ? NetworkImage(
                                      '$baseurl${userProvider.user!.image}',
                                    )
                                  : Image.asset(
                                          'assets/images/default_funding.jpg')
                                      .image,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'From. ${userProvider.user!.username}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.5,
                                  child: Text(
                                    '${remitMap['message']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '내가 펀딩할 금액',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const Text(
                  '금액을 확인하세요.',
                  style: TextStyle(color: Color(0xff7D7D7D)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      '${remitMap['amount'].toString()}원',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    print('tap');
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('정말 펀딩하시겠습니까?'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    // print('start');
                                    bool result = false;
                                    String msg = '';
                                    final req = await Remit.getPayRedirect(
                                        amount: remitMap['amount'],
                                        userid: userProvider.user!.id);

                                    if (context.mounted) {
                                      final res = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => KakaoPay(
                                                    url: req,
                                                    uid: userProvider.user!.id,
                                                  )));
                                      if (res != null) {
                                        result = res['result'];
                                        msg = res['message'];
                                      }
                                    }

                                    if (result) {
                                      result = await Remit.getPayApprove();
                                    }
                                    if (result) {
                                      result = await Remit.postRemit(
                                          remitData: jsonEncode(remitMap));
                                    }
                                    if (context.mounted) {
                                      result
                                          ? {
                                              fundingsProvider.getFundingDetail(
                                                  remitMap['funding']),
                                              fundingsProvider
                                                  .getJoinedfundings(),
                                              Navigator.pop(context),
                                              Navigator.pop(context),
                                              Navigator.pop(context),
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text('결제성공!'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                '닫기'))
                                                      ],
                                                    );
                                                  })
                                            }
                                          : showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Center(
                                                  child: AlertDialog(
                                                    title: const Center(
                                                        child: Text('결제실패')),
                                                    content: Text(msg),
                                                  ),
                                                );
                                              });
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
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      width: screenWidth,
                      height: 50,
                      child: const Center(
                        child: Text(
                          '다음',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
