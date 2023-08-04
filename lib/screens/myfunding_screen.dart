import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../services/api_funding.dart';
import '../widgets/fundingcard.dart';

class MyFundingScreen extends StatelessWidget {
  MyFundingScreen({super.key, required this.page});

  final String page;
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: false);

    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '내 펀딩',
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
                    title: '내 펀딩',
                    sizeX: sizeX,
                    fetchFunding: (page) => Funding.getUserFunding(
                      page: page,
                      id: _userProvider.user!.id,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
