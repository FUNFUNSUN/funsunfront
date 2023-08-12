import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funsunfront/screens/remit_check_screen.dart';

import '../models/funding_model.dart';
import '../widgets/pink_btn.dart';

class RemitScreen extends StatefulWidget {
  const RemitScreen({
    Key? key,
    required this.targetFunding,
  }) : super(key: key);

  final FundingModel targetFunding;

  @override
  State<RemitScreen> createState() => _RemitScreenState();
}

class _RemitScreenState extends State<RemitScreen> {
  final tempAmount = TextEditingController();
  final tempMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    // TODO: 추후 inkwell로 프로필페이지 이동
                    radius: 30,
                    backgroundImage:
                        widget.targetFunding.author!['image'] != null
                            ? NetworkImage(
                                '$baseurl${widget.targetFunding.author!['image']}',
                              )
                            : Image.asset('assets/images/default_profile.jpg')
                                .image,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.targetFunding.author!['username'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      const Text(
                        '님 서포트하기',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Text(widget.targetFunding.id.toString()),
              const Text(
                '서포트할 금액을 입력하세요',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '돈도 마음도 중요하답니다.',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffF4F4F4),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  hintText: '1000원부터 1000만원까지 가능해요',
                ),
                controller: tempAmount,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '축하메세지를 입력하세요',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '친구가 분명 좋아할거에요!',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(bottom: 100, top: 15, left: 10),
                  filled: true,
                  fillColor: const Color(0xffF4F4F4),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  hintText: '생일축하해! 너의 생일을 축하하는 마음으로, \n널 서포트했어!',
                ),
                controller: tempMessage,
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () async {
                    if (tempAmount.text.isEmpty ||
                        int.parse(tempAmount.text) > 1000000 ||
                        int.parse(tempAmount.text) < 1000) {
                      showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: const Text('금액은 1000원부터 100만원까지 가능해요'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('확인'),
                              ),
                            ],
                          );
                        }),
                      );
                    } else if (tempMessage.text.length < 2 ||
                        tempMessage.text.length > 255) {
                      showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: const Text('메세지는 2글자 이상 255글자 이하로 입력해주세요'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('확인'),
                              ),
                            ],
                          );
                        }),
                      );
                    } else {
                      int amount = int.parse(tempAmount.text);
                      String message = tempMessage.text;
                      String id = widget.targetFunding.id.toString();

                      Map<String, dynamic> remitMap = {
                        'amount': amount,
                        'message': message,
                        'funding': id
                      };
                      //확인페이지 -> 카카오페이페이지 -> 결제 -> 결제성공시 요청

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RemitCheckScreen(
                                  remitMap,
                                  widget.targetFunding,
                                )),
                      );
                      // api로 보낼 요청//

                      // var remitJson = jsonEncode(remitMap);
                      // // print(remitJson);
                      // final res = await Remit.postRemit(remitData: remitJson);
                    }
                  },
                  child: const PinkBtn(
                    btnTxt: '서포트하기',
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
