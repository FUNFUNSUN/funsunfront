import 'package:flutter/material.dart';
import '../widgets/fundingcard.dart';

class MySupportScreen extends StatelessWidget {
  const MySupportScreen({super.key, this.page = '1'});

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
                  child: FundingCard(
                    fundingType: 'mySupport',
                    title: '서포트한 펀딩',
                    sizeX: sizeX,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
