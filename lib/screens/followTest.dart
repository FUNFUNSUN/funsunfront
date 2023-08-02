import 'package:flutter/material.dart';

class FollowTest extends StatefulWidget {
  const FollowTest({super.key});

  @override
  _FollowTestState createState() => _FollowTestState();
}

class _FollowTestState extends State<FollowTest>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentPageIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('유저명'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '팔로우 페이지'),
            Tab(text: '팔로잉 페이지'),
          ],
        ),
      ),
      body: currentPageIndex == 0
          ? const FollowerWidget() // 첫 번째 페이지
          : const FolloweeWidget(), // 두 번째 페이지
    );
  }
}

class FollowerWidget extends StatelessWidget {
  const FollowerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('팔로우 페이지'),
    );
  }
}

class FolloweeWidget extends StatelessWidget {
  const FolloweeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('팔로잉 페이지'),
    );
  }
}
