import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/funding_model.dart';
import '../provider/fundings_provider.dart';
import '../screens/funding_screen.dart';
import 'loading_circle.dart';

class FundingCard extends StatelessWidget {
  FundingCard({
    super.key,
    required this.sizeX,
    required this.title,
    required this.fundingType,

    ///'mySupport', 'myFunding', 'public', 'userFunding', 'friendFunding'
  });
  final double sizeX;
  final String title;
  final String fundingType;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    const imgBaseUrl = 'http://projectsekai.kro.kr:5000/';
    FundingsProvider fundingsProvider =
        Provider.of<FundingsProvider>(context, listen: true);

    Future<List<FundingModel>>? fetchFunding(String fundingType) {
      switch (fundingType) {
        case 'mySupport':
          return fundingsProvider.joinedFundings;
        case 'myFunding':
          return fundingsProvider.myFundings;
        case 'public':
          return fundingsProvider.publicFundings;
        case 'userFunding':
          return fundingsProvider.myFundings;
        case 'friendFunding':
          return fundingsProvider.friendFundings;
        default:
          return Future<List<FundingModel>>.value([]);
      }
    }

    return FutureBuilder<List<FundingModel>>(
        future: fetchFunding(fundingType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingCircle();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                '$title이 없습니다.',
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            );
          } else {
            List<FundingModel> fundings = snapshot.data!;

            return (fundings.isNotEmpty)
                ? NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        page++;

                        fundingsProvider.getPublicFundings(1);

                        return true;
                      }
                      return false;
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                      itemCount: fundings.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                        childAspectRatio: 1 / 1.6, //item 의 가로 1, 세로 1 의 비율
                        mainAxisSpacing: 10, //수평 Padding
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        //만료확인변수
                        final bool isExpired =
                            DateTime.parse(fundings[index].expireOn)
                                .isBefore(DateTime.now());

                        return InkWell(
                            onTap: () {
                              fundingsProvider.getFundingDetail(
                                  fundings[index].id.toString());

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FundingScreen(
                                          id: fundings[index].id.toString(),
                                        )),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
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
                                            child:
                                                (fundings[index].image != null)
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  fundings[index].title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          '펀딩종료일',
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                        Text(
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                          DateFormat.yMMMd(
                                                                  'en_US')
                                                              .format(DateTime
                                                                  .parse(fundings[
                                                                          index]
                                                                      .expireOn)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      },
                    ),
                  )
                : Center(
                    child: Text('$title이 없습니다.'),
                  );
          }
        });
  }
}
