import 'package:flutter/material.dart';
import 'package:funsunfront/screens/userscreen.dart';
import 'package:provider/provider.dart';

import '../models/account_model.dart';
import '../provider/fundings_provider.dart';
import '../provider/profile_provider.dart';
import '../provider/user_provider.dart';
import '../services/api_follow.dart';
import '../widgets/loading_circle.dart';
import 'my_screen.dart';

class FollowScreen extends StatefulWidget {
  const FollowScreen({super.key, required this.initIndex, required this.user});
  final int initIndex;
  final AccountModel user;
  @override
  _FollowScreenState createState() => _FollowScreenState();
}

late ProfileProvider _profileProvider;
late FundingsProvider _fundingsProvider;
late UserProvider _userProvider;

class _FollowScreenState extends State<FollowScreen>
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
          widget.user.username,
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
          ? FollowerWidget(user: widget.user) // 팔로워 페이지
          : FolloweeWidget(user: widget.user), // 팔로잉 페이지
    );
  }
}

class FollowerWidget extends StatelessWidget {
  const FollowerWidget({super.key, required this.user});
  final AccountModel user;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _profileProvider = Provider.of<ProfileProvider>(context, listen: true);

    final Future<List<AccountModel>> followerList =
        Follow.getFollowerList(id: user.id);

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
                              _fundingsProvider.getMyfundings(
                                  _profileProvider.profile!.id, 1);
                              if (context.mounted) {
                                if (id != _userProvider.user!.id) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserScreen(id: id),
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
                                      width: 65, // 원의 지름
                                      height: 65, // 원의 지름
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      child: (followerLists[index].image !=
                                              null)
                                          ? Image.network(
                                              '$baseurl${followerLists[index].image}',
                                              fit: BoxFit.cover,
                                            )
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
  const FolloweeWidget({super.key, required this.user});
  final AccountModel user;

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    _userProvider = Provider.of<UserProvider>(context, listen: false);

    final Future<List<AccountModel>> followeeList =
        Follow.getFolloweeList(id: user.id);
    // TODO 여기가 포인트다 profileProvider의 profile을 사용하는 것이 아니라 걍 id 받아올거임

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
                              _fundingsProvider.getMyfundings(
                                  _profileProvider.profile!.id, 1);
                              if (context.mounted) {
                                if (id != _userProvider.user!.id) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserScreen(id: id),
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
                                      width: 65, // 원의 지름
                                      height: 65, // 원의 지름
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      child: (followeeLists[index].image !=
                                              null)
                                          ? Image.network(
                                              '$baseurl${followeeLists[index].image}',
                                              fit: BoxFit.cover,
                                            )
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
