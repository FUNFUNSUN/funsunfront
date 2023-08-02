import 'package:flutter/material.dart';
import 'package:funsunfront/screens/public_screen.dart';
import 'package:funsunfront/screens/searchresult_screen.dart';
import 'package:provider/provider.dart';

import '../models/funding_model.dart';
import '../provider/user_provider.dart';
import '../services/api_funding.dart';
import 'mysupport_screen.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  late UserProvider _userProvider;
  final imgBaseUrl = 'http://projectsekai.kro.kr:5000/';

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: true);
    final Future<List<FundingModel>> publicfunding =
        Funding.getPublicFunding(page: '1');
    final Future<List<FundingModel>> mysupportfunding =
        Funding.getJoinedFunding(page: '1');
    final sizeX = MediaQuery.of(context).size.width;
    //TODO : 정렬수정필요
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchResultScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 48,
                // width: 320,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '검색',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 16),
                      ),
                      Icon(
                        Icons.search_rounded,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          ///////////////////////////////////////////////////////펀딩
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '전체공개펀딩',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PublicScreen(
                                      page: '1',
                                    )),
                          );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /////////////////////////카드
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FutureBuilder(
                    future: publicfunding,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // 오류 표시
                        return Text('오류: ${snapshot.error}');
                      } else {
                        final publicfundings = snapshot.data;
                        publicfundings!;
                        return SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 145,
                                height: 145,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.network(
                                    (publicfundings[0].image != null)
                                        ? '$imgBaseUrl${publicfundings[0].image}'
                                        : 'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg',
                                    fit: BoxFit.cover),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 145,
                                height: 145,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.network(
                                    (publicfundings[1].image != null)
                                        ? '$imgBaseUrl${publicfundings[1].image}'
                                        : 'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg',
                                    fit: BoxFit.cover),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '서포트한 펀딩',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MySupportScreen(
                                      page: '1',
                                    )),
                          );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  // margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FutureBuilder(
                        future: mysupportfunding,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // 오류 표시
                            return Text('오류: ${snapshot.error}');
                          } else {
                            // 펀딩게시글이 있으면
                            final mysupportfundings = snapshot.data;
                            bool isSupportExist = false;
                            if (mysupportfundings!.isNotEmpty) {
                              isSupportExist = true;
                            }

                            return (isSupportExist)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 145,
                                          height: 145,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Image.network(
                                              (mysupportfundings[0].image !=
                                                      null)
                                                  ? '$imgBaseUrl${mysupportfundings[0].image}'
                                                  : 'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg',
                                              fit: BoxFit.cover),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        mysupportfundings.length < 2
                                            ? const SizedBox(
                                                width: 10,
                                              )
                                            : Container(
                                                width: 145,
                                                height: 145,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Image.network(
                                                    (mysupportfundings[1]
                                                                .image !=
                                                            null)
                                                        ? '$imgBaseUrl${mysupportfundings[1].image}'
                                                        : 'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg',
                                                    fit: BoxFit.cover),
                                              ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    height: 145,
                                    child: const Text('서포트한 펀딩이 없습니다.'));
                          }
                        }),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
