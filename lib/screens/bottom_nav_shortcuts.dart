import 'package:flutter/material.dart';
import 'package:funsunfront/screens/exploerScreen_screen.dart';
import 'package:funsunfront/screens/home_screen.dart';
import 'package:funsunfront/screens/user_screen.dart';

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

  @override
  void initState() {
    _currentIndex = widget.initIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          ExploreScreen(),
          HomeScreen(),
          UserScreen(),
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
