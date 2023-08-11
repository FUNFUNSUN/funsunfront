// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funsunfront/widgets/app_bar.dart';

import '../services/api_report.dart';

//타입 : 펀딩이냐 유저냐 댓글이냐를 String으로 보내세용
//타겟: 타입의 아이디
//메세지는 : 뭐가 그리 꼬왔는지
class ReportScreen extends StatelessWidget {
  Map<String, dynamic> report;
  ReportScreen(this.report, {Key? key}) : super(key: key);
  final reportMessage = TextEditingController();

  late String typeTitle;
  setTypeTitle() {
    print(report['type']);
    switch (report['type']) {
      case 'funding':
        typeTitle = '펀딩';
        break;
      case 'account':
        typeTitle = '유저';
        break;
      case 'remit':
        typeTitle = '댓글';
        break;
      default:
        typeTitle = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    setTypeTitle();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FunSunAppBar(
        title: "$typeTitle 신고 페이지",
        content: '신고할 내용을 입력해주세요',
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                '신고 메세지',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '신고하고자 하는 이유를 적어주세요',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 15,
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
                  hintText: '신고사유를 적어주세요',
                ),
                controller: reportMessage,
              ),
              const SizedBox(
                height: 100,
              ),
              InkWell(
                onTap: () async {
                  if (reportMessage.text.length > 255 ||
                      reportMessage.text.length < 2) {
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return const AlertDialog(
                          title: Text('내용확인'),
                        );
                      }),
                    );
                  } else {
                    report['message'] = reportMessage.text;
                    // print(report['type']);
                    // print(report['target']);
                    // print(report['message']);

                    var json = jsonEncode(report);

                    bool reportResult =
                        await Report.postReport(reportData: json);

                    if (context.mounted) {
                      if (reportResult) {
                        showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: const Text('신고되었습니다'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('닫기'))
                              ],
                            );
                          }),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: const Text('신고에 실패하였습니다.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('닫기'))
                              ],
                            );
                          }),
                        );
                      }
                    }
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9),
                        borderRadius: BorderRadius.circular(15)),
                    width: 400,
                    height: 50,
                    child: const Center(
                      child: Text(
                        '신고하기',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    )),
              )
            ],
          ),
        ),
      )),
    );
  }
}
