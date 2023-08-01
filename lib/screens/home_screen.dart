import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _list = ['a', 'b', 'c'];
  //TODO : Fix hardcoding

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshHomeScreen,
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
                        fontWeight: FontWeight.w900,
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
                    SizedBox(
                      child: Image.asset('assets/images/giftBox.png'),
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
                      child: RefreshIndicator(
                        onRefresh: refreshHomeScreen,
                        child: ListView.builder(
                          itemCount: _list.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_list[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> refreshHomeScreen() async {
    // TODO: 여기서 API이용 메소드 작성
    final newList = ['d', 'e', 'f'];
    setState(() {
      _list = [..._list, ...newList];
    });
  }
}
