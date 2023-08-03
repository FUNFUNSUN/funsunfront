import 'package:flutter/material.dart';
import 'package:funsunfront/provider/fundings_provider.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/screens/funding_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _list = ['a', 'b', 'c'];
  //TODO : Fix hardcoding
  late FundingsProvider fundingsProvider;
  late UserProvider userProvider;

  Future<void> refreshFunction() async {
    userProvider.updateUser();
    fundingsProvider.refreshAllFundings(userProvider.user!.id);
    print('done');
  }

  @override
  Widget build(BuildContext context) {
    fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshFunction,
        child: LayoutBuilder(
          builder: ((context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '펀딩을\n시작해보세요!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '\n친구와 서로 펀딩받고, 서포트하세요',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/three_gifts.png',
                        width: 300,
                      ),
                    ),
                    const Text(
                      '\n내 친구들의 펀딩',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorLight
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListView.builder(
                        itemCount: _list.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_list[index]),
                          );
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FundingScreen(id: '41')),
                          );
                        },
                        child: const Text(' 펀딩 임시 이동버튼')),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> refreshHomeScreen(
      FundingsProvider fundingsProvider, String uid) async {
    // TODO: 여기서 API이용 메소드 작성
    final newList = ['d', 'e', 'f'];
    setState(() {
      _list = [..._list, ...newList];
    });
    fundingsProvider.refreshAllFundings(uid);
  }
}
