import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FAQ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '자주 물어보는 질문을 확인하세요',
                  style: TextStyle(color: Color(0xff7D7D7D)),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(children: [
                  Faqwidget(
                    question: '펀딩 100% 초과 달성되면 추가 금액은 어떻게 되나요?',
                    answer: '100% 이상 달성되면 추가 달성된 금액도 함께 정산해드립니다.',
                  ),
                  Faqwidget(
                      question: '펀딩 100%를 달성하지 못하면 어떻게 하나요?',
                      answer: '펀딩 100%를 달성하지 못하더라도, 모인 금액만큼 정산받으실 수 있습니다.'),
                  Faqwidget(
                      question: '펀딩이 완료된 이후 정산 과정은 어떻게 되나요?',
                      answer:
                          '펀딩이 완료되면, FunSun에서 회원님의 등록된 계좌로 펀딩 금액을 정산해드립니다.'),
                  Faqwidget(
                      question: '펀딩 기간이 지났는데 계속 진행하고 싶어요!',
                      answer:
                          '펀딩 기간이 지나면 수정이 어려우니, 가능하시다면 미리 펀딩 기간을 충분히 설정해 주시면 감사하겠습니다.'),
                  Faqwidget(
                      question: '펀딩 진행 중 회원 탈퇴 시, 정산 과정은 어떻게 되나요?',
                      answer:
                          '회원 탈퇴 시, 회원 정보가 삭제되기 때문에 펀딩 정산이 어렵습니다. 이 점 양해 부탁드립니다.'),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Faqwidget extends StatelessWidget {
  final String question, answer;
  const Faqwidget({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedTextColor: Colors.black,
      leading: const Icon(Icons.help_outline_rounded),
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      children: <Widget>[
        ListTile(
          title: Text(answer),
          onTap: () {
            // Do something when item 1 is tapped
          },
        ),
      ],
    );
  }
}
