import 'package:flutter/material.dart';
import 'package:funsunfront/screens/first_screen.dart';
import 'package:funsunfront/screens/view_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _list = ['노이', '예쁜언니', '큰언니'];
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
                          color: Colors.lightBlue[100],
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FirstScreen()),
                        );
                      },
                      child: const Text('테스트용 FirstScreen 라우팅'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewScreen()),
                        );
                      },
                      child: const Text('테스트용 ViewScreen 라우팅'),
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
    // 추후 여기서 API이용 메소드 작성
    final newList = ['원윤선', '정대만', '두송'];
    setState(() {
      _list = [..._list, ...newList];
    });
  }
}
