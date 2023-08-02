import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FAQ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '자주 물어보는 질문을 확인하세요',
                  style: TextStyle(color: Color(0xff7D7D7D)),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Column(children: [
                  Faqwidget(
                    question: '질문1',
                    answer: '답변1',
                  ),
                  Faqwidget(question: '질문2', answer: '답변2'),
                ]),
                InkWell(
                  onTap: () {
                    print('클릭');
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(15)),
                      width: 400,
                      height: 50,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '다음',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          )
                        ],
                      )),
                )
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
      title: Text(question),
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
