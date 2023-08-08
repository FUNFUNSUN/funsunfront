import 'package:flutter/material.dart';
import 'package:funsunfront/widgets/fundingcardTest.dart';

class AllFundingsScreen extends StatelessWidget {
  const AllFundingsScreen({
    super.key,
    this.page = '1',
    required this.title,
    required this.fundingType,
  });

  final String page;
  final String title;
  final String fundingType;

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
            Text(
              title,
              style: const TextStyle(
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
                  child: FundingCardTest(
                    fundingType: fundingType,
                    title: title,
                    sizeX: sizeX,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
