import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/screens/funding_screen.dart';
import 'package:funsunfront/screens/public_screen.dart';
import 'package:funsunfront/screens/searchresult_screen.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

import 'mysupport_screen.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  late UserProvider _userProvider;
  final imgBaseUrl = 'http://projectsekai.kro.kr:5000/';

  var historyList = ListQueue();

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    FundingsProvider fundingsProvider =
        Provider.of<FundingsProvider>(context, listen: true);

    fundingsProvider.getPublicFundings();
    fundingsProvider.getJoinedfundings();

    //TODO : 정렬수정필요
    return Scaffold(
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
                color: Theme.of(context).primaryColorLight.withOpacity(0.5),
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
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 16),
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
                  future: fundingsProvider.publicFundings,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // 오류 표시
                      return Text('오류: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final publicfundings = snapshot.data;
                      publicfundings!;
                      return (publicfundings.isEmpty)
                          ? Container(
                              alignment: Alignment.center,
                              height: 145,
                              child: const Text(
                                '공개 작성된 펀딩이 없습니다.',
                                style: TextStyle(fontSize: 13),
                              ))
                          : SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      fundingsProvider.getFundingDetail(
                                          publicfundings[0].id.toString());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                (FundingScreen(
                                                    id: publicfundings[0]
                                                        .id
                                                        .toString()))),
                                      );
                                    },
                                    child: Container(
                                      //첫번째 펀딩
                                      width: 145,
                                      height: 145,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: (publicfundings[0].image != null)
                                          ? Image.network(
                                              '$imgBaseUrl${publicfundings[0].image}',
                                              fit: BoxFit.cover)
                                          : Image.asset(
                                              'assets/images/default_funding.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  (publicfundings.length == 1)
                                      ? const SizedBox(
                                          width: 145,
                                          height: 145,
                                        )
                                      : InkWell(
                                          onTap: () {
                                            fundingsProvider.getFundingDetail(
                                                publicfundings[1]
                                                    .id
                                                    .toString());
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      (FundingScreen(
                                                          id: publicfundings[1]
                                                              .id
                                                              .toString()))),
                                            );
                                          },
                                          child: Container(
                                            //두번째 펀딩
                                            width: 145,
                                            height: 145,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: (publicfundings[1].image !=
                                                    null)
                                                ? Image.network(
                                                    '$imgBaseUrl${publicfundings[1].image}',
                                                    fit: BoxFit.cover)
                                                : Image.asset(
                                                    'assets/images/default_funding.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                ],
                              ),
                            );
                    }
                    return const Center(child: CircularProgressIndicator());
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FutureBuilder(
                    future: fundingsProvider.joinedFundings,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        fundingsProvider.getFundingDetail(
                                            mysupportfundings[0].id.toString());
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  (FundingScreen(
                                                      id: mysupportfundings[0]
                                                          .id
                                                          .toString()))),
                                        );
                                      },
                                      child: Container(
                                        //첫번째 펀딩
                                        width: 145,
                                        height: 145,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: (mysupportfundings[0].image !=
                                                null)
                                            ? Image.network(
                                                '$imgBaseUrl${mysupportfundings[0].image}',
                                                fit: BoxFit.cover)
                                            : Image.asset(
                                                'assets/images/default_funding.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    mysupportfundings.length < 2
                                        ? const SizedBox(
                                            width: 145,
                                          )
                                        : InkWell(
                                            onTap: () {
                                              fundingsProvider.getFundingDetail(
                                                  mysupportfundings[1]
                                                      .id
                                                      .toString());
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        (FundingScreen(
                                                            id: mysupportfundings[
                                                                    1]
                                                                .id
                                                                .toString()))),
                                              );
                                            },
                                            child: Container(
                                              //두번째 펀딩
                                              width: 145,
                                              height: 145,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: (mysupportfundings[1]
                                                          .image !=
                                                      null)
                                                  ? Image.network(
                                                      '$imgBaseUrl${mysupportfundings[1].image}',
                                                      fit: BoxFit.cover)
                                                  : Image.asset(
                                                      'assets/images/default_funding.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                  ],
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: 145,
                                child: const Text(
                                  '서포트한 펀딩이 없습니다.',
                                  style: TextStyle(fontSize: 13),
                                ));
                      }
                    }),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
