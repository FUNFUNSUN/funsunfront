import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: SearchBox(appBar: AppBar()),
        //body: //검색 히스토리 위젯 빌드,
      ),
    );
  }
}

class SearchBox extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const SearchBox({
    super.key,
    required this.appBar,
  });

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextField(
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
    );
  }
}

List<dynamic> users = [];
