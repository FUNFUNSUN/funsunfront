import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/funding_model.dart';
import '../screens/funding_screen.dart';

class FundingCard extends StatelessWidget {
  const FundingCard({
    super.key,
    required this.sizeX,
    required this.fundings,
  });
  final List<FundingModel> fundings;
  final double sizeX;

  final imgBaseUrl = 'http://projectsekai.kro.kr:5000/';

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
      itemCount: fundings.length,
      physics: const AlwaysScrollableScrollPhysics(),
      // shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
        childAspectRatio: 1 / 1.6, //item 의 가로 1, 세로 1 의 비율
        mainAxisSpacing: 10, //수평 Padding
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FundingScreen(
                        id: fundings[index].id.toString(),
                      )),
            );
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 5.0,
                      offset: const Offset(1, .8))
                ]),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    width: sizeX,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: (fundings[index].image != null)
                          ? Image.network(
                              '$imgBaseUrl${fundings[index].image}',
                              //펀딩이미지
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/default_funding.jpg',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            fundings[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('펀딩종료일'),
                                  Text(
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    DateFormat.yMMMd('en_US').format(
                                        DateTime.parse(
                                            fundings[index].expireOn)),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
