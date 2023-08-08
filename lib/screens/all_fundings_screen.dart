import 'package:flutter/material.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/provider/profile_provider.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/widgets/fundingcardTest.dart';
import 'package:provider/provider.dart';

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
    final FundingsProvider fundingsProvider =
        Provider.of<FundingsProvider>(context, listen: true);
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        await profileProvider.updateProfile(user!.id);
        fundingsProvider.refreshAllFundings(user.id); // pop할 때 메소드 호출
        print('굥선이가 뒤로가기를 눌렀다');
        return true; // 페이지를 pop 허용
      },
      child: Scaffold(
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
      ),
    );
  }
}
