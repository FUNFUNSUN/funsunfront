import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/models/account_model.dart';
import 'package:funsunfront/provider/profile_provider.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:funsunfront/screens/my_screen.dart';
import 'package:funsunfront/screens/userscreen.dart';
import 'package:funsunfront/services/api_account.dart';
import 'package:funsunfront/widgets/search_history.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBox();
  }
}

class SearchBox extends StatefulWidget {
  SearchBox({
    super.key,
  });
  bool isSubmit = false;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _searchController =
      TextEditingController(); // 검색어 입력을 제어하는 컨트롤러

  // bool isUserExist = false; //유저 검색 시 테스트용 변수입니다.

  List<AccountModel> searchedUsers = [];
  final storage = const FlutterSecureStorage();

  // final LocalStorage localStorage = LocalStorage('historyList.json');

  LinkedList<HistoryItem> historyList = LinkedList<HistoryItem>();

  Future<void> initHistory() async {
    String? historydata = await storage.read(key: 'historyList.json');
    if (historydata != null) {
      final historydatas = jsonDecode(historydata);

      for (var itm in historydatas) {
        historyList.add(HistoryItem(itm['id'], itm['username'], itm['image']));
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initHistory();
    setState(() {
      widget.isSubmit = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // 메모리 누수를 방지하기 위해 컨트롤러를 dispose합니다.
    List historydata = saveHistory();
    storage.write(key: 'historyList.json', value: jsonEncode(historydata));
    super.dispose();
  }

  List saveHistory() {
    List data = [];
    for (var itm in historyList) {
      data.add(itm.toMap());
    }
    return data;
  }

  List<Widget> getHistory() {
    String baseUrl = 'http://projectsekai.kro.kr:5000/';
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: true);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    List<Widget> data = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '검색 기록',
              style: TextStyle(fontSize: 20),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {});
                  historyList.clear();
                },
                child: const Text('검색 기록 삭제'))
          ],
        ),
      ),
    ];
    for (var itm in historyList) {
      Widget historyProfile = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 5),
        child: InkWell(
          onTap: () async {
            await profileProvider.updateProfile(itm.id);
            if (context.mounted) {
              if (userProvider.user!.id != itm.id) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserScreen(id: itm.id),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyScreen(),
                  ),
                );
              }
            }
          },
          child: SizedBox(
              height: 70,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                ClipOval(
                  child: Container(
                    width: 70, // 원의 지름
                    height: 70, // 원의 지름
                    color: Theme.of(context).primaryColorLight,
                    child: (itm.image != null)
                        ? Image.network('$baseUrl${itm.image}',
                            fit: BoxFit.cover)
                        : Image.asset('assets/images/default_profile.jpg',
                            fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  itm.username,
                  style: const TextStyle(fontSize: 16),
                ),
              ])),
        ),
      );
      data.add(historyProfile);
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    const String baseUrl = 'http://projectsekai.kro.kr:5000/';
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    Future searchUserFn(value) async {
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
                      style: TextStyle(color: Theme.of(context).primaryColor),
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
    }

    // 유저 검색 히스토리

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                setState(() {
                  widget.isSubmit = true;
                });
                await searchUserFn(value);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                suffixIcon: IconButton(
                    onPressed: () async {
                      await searchUserFn(_searchController.text);
                    },
                    icon: const Icon(Icons.search_rounded)),
                filled: true,
                fillColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
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
        body: Container(
          child: (() {
            if (widget.isSubmit && searchedUsers.isNotEmpty) //검색했고, 결과 있음
            {
              //검색결과

              return ListView.builder(
                  //검색결과가 있으면 이니까 검색결과
                  itemCount: searchedUsers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: InkWell(
                        onTap: () async {
                          final user = searchedUsers[index];
                          setState(() {});
                          if (historyList.isEmpty) {
                            historyList.add(HistoryItem(
                                user.id, user.username, user.image));
                          } else if (historyList.length < 5) {
                            HistoryItem? duplicate;
                            for (var item in historyList) {
                              if (item.id == user.id) {
                                duplicate = item;
                              }
                            }
                            if (duplicate != null) {
                              historyList.remove(duplicate);
                            }

                            historyList.first.insertBefore(HistoryItem(
                                user.id, user.username, user.image));
                          } else {
                            HistoryItem? duplicate;
                            for (var item in historyList) {
                              if (item.id == user.id) {
                                duplicate = item;
                              }
                            }
                            if (duplicate != null) {
                              historyList.remove(duplicate);
                            }

                            historyList.remove(historyList.last);
                            historyList.first.insertBefore(HistoryItem(
                                user.id, user.username, user.image));
                          }

                          await profileProvider.updateProfile(user.id);
                          if (context.mounted) {
                            if (userProvider.user!.id != user.id) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserScreen(id: user.id),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyScreen(),
                                ),
                              );
                            }
                          }
                        },
                        child: SizedBox(
                          height: 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 70, // 원의 지름
                                  height: 70, // 원의 지름
                                  color: Theme.of(context).primaryColorLight,
                                  child: (searchedUsers[index].image != null)
                                      ? Image.network(
                                          '$baseUrl${searchedUsers[index].image}',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/default_profile.jpg',
                                          fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                searchedUsers[index].username,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else if (widget.isSubmit && searchedUsers.isEmpty) //검색했지만 결과없음
            {
              //검색결과없음
              return const Center(
                child: Text('검색결과가 없습니다.'),
              );
            } else if (historyList.isNotEmpty) //검색안했고 기록 있으면
            {
              //검색기록
              return Column(
                children: getHistory(),
              );
            } else //검색안했고 기록 없으면
            {
              return const Center(
                child: Text('검색기록이 없습니다.'),
              );
            }
          })(),
        ));
  }
}
