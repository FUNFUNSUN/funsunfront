import 'package:flutter/material.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/provider/profile_provider.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/widgets/app_bar.dart';
import 'package:funsunfront/widgets/fundingcard.dart';
import 'package:provider/provider.dart';

class AllFundingsScreen extends StatelessWidget {
  const AllFundingsScreen({
    super.key,
    this.page = '1',
    required this.title,
    required this.fundingType,
    this.uid,
  });

  final String page;
  final String title;
  final String fundingType;
  final String? uid;

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

        return true; // 페이지를 pop 허용
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: FunSunAppBar(
          title: title,
          content: '',
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                    width: sizeX,
                    height: sizeY,
                    child: FundingCard(
                      fundingType: fundingType,
                      title: title,
                      sizeX: sizeX,
                      uid: uid,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
