import 'package:flutter/material.dart';
import 'package:funsunfront/models/funding_model.dart';
import 'package:funsunfront/screens/funding_screen.dart';
import 'package:funsunfront/widgets/loading_circle.dart';

class FundingCardHorizon extends StatelessWidget {
  const FundingCardHorizon({
    super.key,
    required this.sizeX,
    required this.fundings,
    required this.title,
  });
  final String title;
  final double sizeX;
  final Future<List<FundingModel>> fundings;

  @override
  Widget build(BuildContext context) {
    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    return FutureBuilder(
        future: fundings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터를 불러오는 동안 로딩 표시
            return const LoadingCircle();
          } else if (snapshot.hasError) {
            // 오류 표시
            return Text('오류: ${snapshot.error}');
          } else {
            final userfundings = snapshot.data;
            userfundings!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: sizeX,
                    height: 150,
                    child: (userfundings.isEmpty)
                        ? SizedBox(
                            height: 150,
                            child: Center(
                              child: Text(
                                '$title이 없습니다.',
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.only(right: 20),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: userfundings.length,
                            itemBuilder: (context, index) {
                              String postid =
                                  snapshot.data![index].id.toString();
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FundingScreen(
                                              id: postid,
                                            )),
                                  );
                                },
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: (userfundings[index].image != null)
                                        ? Image.network(
                                            '$baseurl${userfundings[index].image}',
                                            fit: BoxFit.cover)
                                        : Image.asset(
                                            'assets/images/default_funding.jpg',
                                            fit: BoxFit.cover,
                                          ) //펀딩이미지
                                    ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 10);
                            },
                          )),
              ],
            );
          }
        });
  }
}
