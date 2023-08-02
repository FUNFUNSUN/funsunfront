import 'package:flutter/material.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/funding_model.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '작성한 내용을 확인해주세요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                    // TODO: 추후 inkwell로 프로필페이지 이동
                    radius: 50,
                    backgroundImage: targetFunding.image != null
                        ? NetworkImage(
                            '$baseurl${targetFunding.image}',
                          )
                        : Image.asset('assets/images/giftBox.png').image,
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
                height: 20,
              ),
              Container(
                color: const Color.fromARGB(255, 255, 159, 208),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            // TODO: 추후 inkwell로 프로필페이지 이동
                            radius: 30,
                            backgroundImage: userProvider.user!.image != null
                                ? NetworkImage(
                                    '$baseurl${userProvider.user!.image}',
                                  )
                                : Image.asset('assets/images/giftBox.png')
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
                height: 10,
              ),
              Container(
                height: 50,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  remitMap['message'],
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w400),
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
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  remitMap['amount'].toString(),
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => PreviewScreen(temp, image)),
                  // );
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9),
                        borderRadius: BorderRadius.circular(15)),
                    width: 400,
                    height: 50,
                    child: const Center(
                      child: Text(
                        '다음',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
