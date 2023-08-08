// ignore_for_file: must_be_immutable

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/screens/all_fundings_screen.dart';

import 'package:funsunfront/screens/searchresult_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/fundingcard_horizon.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  late FundingsProvider fundingsProvider;
  final imgBaseUrl = 'http://projectsekai.kro.kr:5000/';
  var historyList = ListQueue();

  Future<void> refreshFunction() async {
    fundingsProvider.getPublicFundings(1);
    fundingsProvider.getJoinedfundings(1);
    print('refreshed');
  }

  @override
  Widget build(BuildContext context) {
    fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);
    double sizeX = MediaQuery.of(context).size.width;
    // refreshFunction();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: RefreshIndicator(
        onRefresh: refreshFunction,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: FundingCardHorizon(
                  fundingType: 'public',
                  routeFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllFundingsScreen(
                          title: '전체공개펀딩',
                          fundingType: 'public',
                          page: '1',
                        ),
                      ),
                    );
                  },
                  sizeX: sizeX,
                  title: '전체공개펀딩',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 35),
                child: FundingCardHorizon(
                  fundingType: 'mySupport',
                  routeFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllFundingsScreen(
                          title: '서포트한 펀딩',
                          fundingType: 'mySupport',
                          page: '1',
                        ),
                      ),
                    );
                  },
                  sizeX: sizeX,
                  title: '서포트한 펀딩',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
