import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account_model.dart';
import '../provider/profile_provider.dart';
import '../services/api_follow.dart';
import '../widgets/loading_circle.dart';

class FollowTest extends StatefulWidget {
  const FollowTest({super.key, required this.initIndex});
  final int initIndex;

  @override
  _FollowTestState createState() => _FollowTestState();
}

// late UserProvider _userProvider;
late ProfileProvider _profileProvider;

class _FollowTestState extends State<FollowTest>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = widget.initIndex;
    currentPageIndex = widget.initIndex;
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
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(_profileProvider.profile!.username),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '팔로워 페이지'),
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
    // _userProvider = Provider.of<UserProvider>(context, listen: true);
    _profileProvider = Provider.of<ProfileProvider>(context, listen: true);

    final Future<List<AccountModel>> followerList =
        Follow.getFollowerList(id: _profileProvider.profile!.id);

    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    return FutureBuilder(
        future: followerList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터를 불러오는 동안 로딩 표시
            return const LoadingCircle();
          } else if (snapshot.hasError) {
            // 오류 표시
            return Text('오류: ${snapshot.error}');
          } else {
            final followerLists = snapshot.data;

            return (followerLists!.isEmpty)
                ? const Center(
                    child: Text('팔로우한 사람이 없습니다.'),
                  )
                : ListView.builder(
                    itemCount: followerLists.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 70,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipOval(
                              child: Container(
                                width: 70, // 원의 지름
                                height: 70, // 원의 지름
                                color: Theme.of(context).primaryColorLight,
                                child: (followerLists[index].image != null)
                                    ? Image.network(
                                        '$baseurl${followerLists[index].image}')
                                    : Image.asset('assets/images/giftBox.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text(followerLists[index].username)],
                            )
                          ],
                        ),
                      );
                    });
          }
        });
  }
}

class FolloweeWidget extends StatelessWidget {
  const FolloweeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: true);

    final Future<List<AccountModel>> followeeList =
        Follow.getFolloweeList(id: _profileProvider.profile!.id);

    const String baseurl = 'http://projectsekai.kro.kr:5000/';
    return FutureBuilder(
        future: followeeList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터를 불러오는 동안 로딩 표시
            return const LoadingCircle();
          } else if (snapshot.hasError) {
            // 오류 표시
            return Text('오류: ${snapshot.error}');
          } else {
            final followeeLists = snapshot.data;

            return (followeeLists!.isEmpty)
                ? const Center(
                    child: Text('팔로우한 사람이 없습니다.'),
                  )
                : ListView.builder(
                    itemCount: followeeLists.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 70,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipOval(
                              child: Container(
                                width: 70, // 원의 지름
                                height: 70, // 원의 지름
                                color: Theme.of(context).primaryColorLight,
                                child: (followeeLists[index].image != null)
                                    ? Image.network(
                                        '$baseurl${followeeLists[index].image}')
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
                                Text(followeeLists[index].username),
                              ],
                            )
                          ],
                        ),
                      );
                    });
          }
        });
  }
}
