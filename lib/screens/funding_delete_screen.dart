import 'package:flutter/material.dart';

class FundingDeleteScreen extends StatelessWidget {
  FundingDeleteScreen(this.id, {Key? key}) : super(key: key);
  String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: const Text(
                    '펀딩을 삭제하게 될 경우, 되돌릴 수 없으며, 현재까지 모인 금액 또한 환불 받을 수 없습니다.  '),
              ),
              InkWell(
                onTap: () {
                  AlertDialog(
                    title: const Text('정말 수정하시겠습니까?'),
                    content: const Text('되돌릴 수 없습니다.'),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            if (context.mounted) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('확인')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('취소')),
                    ],
                  );
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
