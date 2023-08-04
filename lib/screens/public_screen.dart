import 'package:flutter/material.dart';

import '../services/api_funding.dart';
import '../widgets/fundingcard.dart';

class PublicScreen extends StatelessWidget {
  const PublicScreen({super.key, required this.page});

  final String page;

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
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
            Expanded(
              child: SizedBox(
                  width: sizeX,
                  height: sizeY,
                  child: FundingCard(
                    title: '전체공개펀딩',
                    sizeX: sizeX,
                    fetchFunding: (page) =>
                        Funding.getPublicFunding(page: page),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
