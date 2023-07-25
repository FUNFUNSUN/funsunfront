import 'package:flutter/material.dart';

class test extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "Texto $index");

  test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: Search(widget.list));
              },
              child: const Icon(Icons.search),
            )
          ],
          centerTitle: true,
          title: const Text('Search Bar'),
        ),
        body: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              widget.list[index],
            ),
          ),
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = " ";
          },
          icon: const Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  late String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(child: Text(selectedResult)),
    );
  }

  final List<String> listExample;
  Search(this.listExample);
  List<String> recentList = ["Text 4", "Text 3"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList.addAll(listExample.where(
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          leading:
              query.isEmpty ? const Icon(Icons.access_time) : const SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
