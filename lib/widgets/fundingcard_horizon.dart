import 'package:flutter/material.dart';
import 'package:funsunfront/models/funding_model.dart';
import 'package:funsunfront/screens/funding_screen.dart';
import 'package:provider/provider.dart';

import '../provider/fundings_provider.dart';
import 'loading_circle.dart';

class FundingCardHorizon extends StatelessWidget {
  const FundingCardHorizon({
    Key? key,
    required this.sizeX,
    required this.title,
    this.routeFunction,
    required this.fundingType,
  }) : super(key: key);

  final String title;
  final double sizeX;
  final Function? routeFunction;
  final String fundingType;

  @override
  Widget build(BuildContext context) {
    const String baseurl = 'http://projectsekai.kro.kr:5000/';
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
        default:
          return Future<List<FundingModel>>.value([]);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title),
            (routeFunction != null)
                ? IconButton(
                    onPressed: () {
                      routeFunction!();
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 20,
                    ),
                  )
                : const SizedBox(
                    width: 5,
                  ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: sizeX,
          height: 150,
          child: FutureBuilder<List<FundingModel>>(
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
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      return true;
                    }
                    return false;
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.only(right: 20),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final funding = snapshot.data![index];
                      final String postid = funding.id.toString();
                      final bool isExpired = DateTime.parse(funding.expireOn)
                          .isBefore(DateTime.now());
                      return GestureDetector(
                        onTap: () {
                          fundingsProvider.getFundingDetail(postid);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FundingScreen(
                                id: postid,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: (funding.image != null)
                                  ? Image.network(
                                      '$baseurl${funding.image}',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/default_funding.jpg',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            if (isExpired)
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Theme.of(context)
                                        .primaryColorLight
                                        .withOpacity(0.6),
                                  ),
                                  child: const Text(
                                    '만료된 \n펀딩',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
