import 'package:flutter/material.dart';
import 'package:funsunfront/screens/userscreen.dart';
import 'package:provider/provider.dart';

import '../models/account_model.dart';
import '../provider/fundings_provider.dart';
import '../provider/profile_provider.dart';
import '../services/api_follow.dart';
import '../widgets/loading_circle.dart';

class FollowTest extends StatefulWidget {
  const FollowTest({super.key, required this.initIndex});
  final int initIndex;
  @override
  _FollowTestState createState() => _FollowTestState();
}

late ProfileProvider _profileProvider;
late FundingsProvider _fundingsProvider;

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
    _fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          _profileProvider.profile!.username,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        bottom: TabBar(
          indicatorColor: Theme.of(context).primaryColor,
          controller: _tabController,
          tabs: const [
            Tab(text: '팔로워'),
            Tab(text: '팔로잉'),
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
                    child: Text('팔로우하는 사람이 여기에 표시됩니다.'),
                  )
                : ListView.builder(
                    itemCount: followerLists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: InkWell(
                            onTap: () async {
                              final id = followerLists[index].id;
                              await _profileProvider.updateProfile(id);
                              _fundingsProvider
                                  .getMyfundings(_profileProvider.profile!.id);
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: 65, // 원의 지름
                                      height: 65, // 원의 지름
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      child: (followerLists[index].image !=
                                              null)
                                          ? Image.network(
                                              '$baseurl${followerLists[index].image}')
                                          : Image.asset(
                                              'assets/images/default_profile.jpg'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    followerLists[index].username,
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ));
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
                    child: Text('팔로잉하는 사람이 여기 표시됩니다.'),
                  )
                : ListView.builder(
                    itemCount: followeeLists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: InkWell(
                            onTap: () async {
                              final id = followeeLists[index].id;
                              await _profileProvider.updateProfile(id);
                              _fundingsProvider
                                  .getMyfundings(_profileProvider.profile!.id);
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: 65, // 원의 지름
                                      height: 65, // 원의 지름
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      child: (followeeLists[index].image !=
                                              null)
                                          ? Image.network(
                                              '$baseurl${followeeLists[index].image}')
                                          : Image.asset(
                                              'assets/images/default_profile.jpg'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    followeeLists[index].username,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    });
          }
        });
  }
}
