import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:funsunfront/screens/explore_screen.dart';
import 'package:funsunfront/screens/first_screen.dart';
import 'package:funsunfront/screens/home_screen.dart';
import 'package:funsunfront/screens/my_screen.dart';
import 'package:provider/provider.dart';

import '../models/account_model.dart';
import '../provider/fundings_provider.dart';
import '../provider/user_provider.dart';
import '../services/api_account.dart';

class BottomNavShortcuts extends StatefulWidget {
  final int initIndex;
  const BottomNavShortcuts({
    Key? key,
    this.initIndex = 1,
  }) : super(key: key);

  @override
  State<BottomNavShortcuts> createState() => _BottomNavShortcutsState();
}

class _BottomNavShortcutsState extends State<BottomNavShortcuts> {
  late int _currentIndex;
  late UserProvider _userProvider;
  late FundingsProvider _fundingsProvider;
  late AccountModel user;

  void initfuction() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'accessToken');

    if (value != null) {
      user = await User.accessTokenLogin();
      _userProvider.setLogin("logged");
      _userProvider.setUser(user);
      _fundingsProvider.getMyfundings(_userProvider.user!.id);
      _fundingsProvider.getJoinedfundings();
      _fundingsProvider.getPublicFundings();
    } else {
      _userProvider.setLogin("");
    }
  }

  @override
  void initState() {
    _currentIndex = widget.initIndex;
    super.initState();
    initfuction();
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: true);
    _fundingsProvider = Provider.of<FundingsProvider>(context, listen: false);

    switch (_userProvider.logged) {
      case 'loading':
        return const Center(child: CircularProgressIndicator());
      case '':
        return const FirstScreen();
      default:
        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: [
              ExploreScreen(),
              const HomeScreen(),
              MyScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'User',
              ),
            ],
          ),
        );
    }
  }
}
