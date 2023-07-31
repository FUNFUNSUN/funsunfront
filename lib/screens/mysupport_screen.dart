import 'package:flutter/material.dart';
import '../models/funding_model.dart';
import '../services/api_funding.dart';
import '../widgets/fundingcard.dart';

class MySupportScreen extends StatelessWidget {
  const MySupportScreen({super.key, required this.page});

  final String page;

  @override
  Widget build(BuildContext context) {
    final Future<List<FundingModel>> fundings = Funding.getJoinedFunding(page);

    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '서포트한 펀딩',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SizedBox(
                  width: sizeX,
                  height: sizeY,
                  child: FutureBuilder(
                    future: fundings,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // 데이터를 불러오는 동안 로딩 표시
                        return const CircularProgressIndicator();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
