import 'package:flutter/material.dart';
import 'package:funsunfront/models/account_model.dart';
import 'package:funsunfront/provider/profile_provider.dart';
import 'package:funsunfront/screens/userscreen.dart';
import 'package:funsunfront/services/api_account.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchBox();
  }
}

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  List<dynamic> searchHistory = []; // 가상의 검색 기록 데이터

  final TextEditingController _searchController =
      TextEditingController(); // 검색어 입력을 제어하는 컨트롤러

  // bool isUserExist = false; //유저 검색 시 테스트용 변수입니다.

  List<AccountModel> searchedUsers = [];

  @override
  void dispose() {
    _searchController.dispose(); // 메모리 누수를 방지하기 위해 컨트롤러를 dispose합니다.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String baseUrl = 'http://projectsekai.kro.kr:5000/';
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextField(
            controller: _searchController, // 컨트롤러를 할당합니다.
            // onChanged: (value) {
            //   //검색어 변경 시 동작할 코드 추가, 검색어 입력할 때마다 호출되는부분
            // },
            onSubmitted: (value) async {
              // 검색어 제출 시 동작할 코드 추가
              // 검색어를 입력하고 검색 버튼(키보드의 검색/엔터 키)을 누르면 이 부분이 호출됩니다.

              if (value.length < 2) {
                showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      title: const Text('2글자 이상 입력해주세요.'),
                      actions: <Widget>[
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "확인",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  }),
                );
              } else {
                searchedUsers = await User.userSearch(username: value);
              }
              setState(() {});
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              suffixIcon: const Icon(Icons.search_rounded),
              filled: true,
              fillColor: const Color(0xFFD9D9D9),
              hintText: '검색',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ),
      ), //////////////검색바END
      body: (searchedUsers.isEmpty)
          ? const Center(child: Text('검색 결과가 없습니다.'))
          : ListView.builder(
              itemCount: searchedUsers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: InkWell(
                    onTap: () async {
                      final id = searchedUsers[index].id;
                      await profileProvider.updateProfile(id);
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserScreen(id: id),
                          ),
                        );
                      }
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipOval(
                            child: Container(
                              width: 70, // 원의 지름
                              height: 70, // 원의 지름
                              color: Theme.of(context).primaryColorLight,
                              child: (searchedUsers[index].image != null)
                                  ? Image.network(
                                      '$baseUrl${searchedUsers[index].image}')
                                  : Image.asset('assets/images/giftBox.png'),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(searchedUsers[index].username),
                              const Text('팔로잉 여부'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
