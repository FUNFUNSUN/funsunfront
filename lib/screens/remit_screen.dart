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
    return MaterialApp(
      home: Scaffold(
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
                      backgroundImage: widget.targetFunding.image != null
                          ? NetworkImage(
                              '$baseurl${widget.targetFunding.image}',
                            )
                          : Image.asset('assets/images/giftBox.png').image,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(widget.targetFunding.title),
                  ],
                ),
                Text(
                  widget.targetFunding.id.toString(),
                ),
                const Text(
                  '펀딩할 금액을 입력하세요',
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
                  height: 5,
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
                    hintText: '안녕',
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
                    hintText: '안녕',
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
                      if (int.parse(tempAmount.text) > 10000000 ||
                          int.parse(tempAmount.text) < 1000) {
                        showDialog(
                          context: context,
                          builder: ((context) {
                            return const AlertDialog(
                              title: Text('금액 확인'),
                            );
                          }),
                        );
                      } else if (tempMessage.text.length < 2 ||
                          tempMessage.text.length > 255) {
                        showDialog(
                          context: context,
                          builder: ((context) {
                            return const AlertDialog(
                              title: Text('메세지 확인'),
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
                      btnTxt: '펀딩하기',
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
