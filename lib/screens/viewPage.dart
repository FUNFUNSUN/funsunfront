import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    double percent = 0.5;
    double tmp = percent * 100;
    int temp = tmp.toInt();
    String percentStr = temp.toString();

    int date = 3;
    String dateStr = date.toString();

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 400,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF4F4F4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$percentStr% 달성!',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  size: 15,
                                ),
                                Text(
                                  '$dateStr일 남음',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment:
                                  FractionalOffset(percent, 1.0 - percent),
                              child: const FractionallySizedBox(
                                child: Icon(
                                  Icons.directions_run,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LinearPercentIndicator(
                                  barRadius: const Radius.circular(10),
                                  percent: percent,
                                  lineHeight: 10,
                                  backgroundColor: Colors.pink.shade100,
                                  progressColor: const Color(0xffFF80C0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    '제목',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    '내용',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 320,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffFF80C0),
                        ),
                        child: const Text(
                          '펀딩하기',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
