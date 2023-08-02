import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AchievementRate extends StatelessWidget {
  late double percent;
  final int date;
  final int hour;

  AchievementRate({
    required this.percent,
    required this.date,
    required this.hour,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String percentStr;
    if (percent >= 1.0) {
      percentStr = (percent * 100).toStringAsFixed(0);
      percent = 1.0;
    } else {
      percentStr = (percent * 100).toStringAsFixed(0);
    }

    final String dateStr = date.toString();
    final String hourStr = hour.toString();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(children: [
      Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.1,
        decoration: BoxDecoration(
          color: const Color(0xffF4F4F4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    (date + hour > 0) ? '$dateStr일 $hourStr시간 남음' : '만료됨',
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearPercentIndicator(
                    widgetIndicator: const Icon(
                      Icons.directions_run,
                      color: Colors.black,
                      size: 20,
                    ),
                    barRadius: const Radius.circular(10),
                    percent: percent,
                    animation: true,
                    animationDuration: 1200,
                    lineHeight: 10,
                    backgroundColor:
                        Theme.of(context).primaryColorLight.withOpacity(0.4),
                    progressColor: Theme.of(context).primaryColor,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ],
              ),
            ],
          ),
        ]),
      )
    ]);
  }
}
