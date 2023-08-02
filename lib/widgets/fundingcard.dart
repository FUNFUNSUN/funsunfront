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
                      child: Image.network(
                        (fundings[index].image != null)
                            ? '$imgBaseUrl${fundings[index].image}'
                            : 'https://scontent-ssn1-1.xx.fbcdn.net/v/t39.30808-6/298331605_2612622035555714_7716975555145679769_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=973b4a&_nc_ohc=LI675SDvZuoAX_k7rf0&_nc_oc=AQnS0gC1D7bqAQKCchCh3DXlmriJ6b2B7hs4Zq9b3-bPVnlHmrf0B1gcmwpxXR34n24&_nc_ht=scontent-ssn1-1.xx&oh=00_AfDWYObdFeP4J0VeYDLRoppDAv37mH7pbMkIS47u2MVB6g&oe=64CA8C86', //펀딩이미지
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
                          Text(fundings[index].title,
                              overflow: TextOverflow.ellipsis),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('펀딩종료일'),
                                  Text(DateFormat.yMMMd('en_US').format(
                                      DateTime.parse(
                                          fundings[index].expireOn))),
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
