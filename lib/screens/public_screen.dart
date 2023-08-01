import 'package:flutter/material.dart';
import 'package:funsunfront/models/funding_model.dart';

import '../services/api_funding.dart';
import '../widgets/fundingcard.dart';

class PublicScreen extends StatelessWidget {
  const PublicScreen({super.key, required this.page});

  final String page;

  @override
  Widget build(BuildContext context) {
    final Future<List<FundingModel>> fundings = Funding.getPublicFunding(page);

    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '전체공개펀딩',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      // color: const Color(0xffE7F5F6),
                      borderRadius: BorderRadius.circular(15)),
                  width: sizeX,
                  height: sizeY,
                  child: FutureBuilder(
                    future: fundings,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // 데이터를 불러오는 동안 로딩 표시
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // 오류 표시
                        return Text('오류: ${snapshot.error}');
                      } else {
                        return FundingCard(
                          sizeX: sizeX,
                          fundings: snapshot.data!,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
