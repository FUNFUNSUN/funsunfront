import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SearchBox());
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

  bool isUserExist = false; //유저 검색 시 테스트용 변수입니다.

  @override
  void dispose() {
    _searchController.dispose(); // 메모리 누수를 방지하기 위해 컨트롤러를 dispose합니다.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: _searchController, // 컨트롤러를 할당합니다.
              onChanged: (value) {
                //검색어 변경 시 동작할 코드 추가, 검색어 입력할 때마다 호출되는부분
              },
              onSubmitted: (value) {
                // 검색어 제출 시 동작할 코드 추가
                // 검색어를 입력하고 검색 버튼(키보드의 검색/엔터 키)을 누르면 이 부분이 호출됩니다.
                if (value.isNotEmpty) {
                  setState(() {
                    searchHistory.add(value);
                  });
                  _searchController.clear();
                }
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
        ),
        body: searchHistory.isEmpty
            ? const Center(child: Text('검색 기록이 없습니다.'))
            : ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  if (isUserExist == true) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Container(
                              width: 70, // 원의 지름
                              height: 70, // 원의 지름
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text('유저1'), Text('팔로잉 여부')],
                          )
                        ],
                      ),
                    );
                  } else if (isUserExist == false) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(searchHistory[index]),
                          const Icon(Icons.close_rounded),
                        ],
                      ),
                      onTap: () {
                        // 검색 기록을 선택했을 때 동작할 코드 추가
                        // 이 부분에서 선택한 검색 기록을 이용하여 원하는 동작을 수행합니다.
                      },
                    );
                  }
                  return null;
                },
              ),
      ),
    );
  }
}
