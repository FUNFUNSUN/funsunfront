import 'package:flutter/material.dart';
import 'package:funsunfront/screens/explore_screen.dart';
import 'package:funsunfront/screens/home_screen.dart';
import 'package:funsunfront/screens/user_screen.dart';

class BottomNavShortcuts extends StatefulWidget {
  const BottomNavShortcuts({super.key});

  @override
  State<BottomNavShortcuts> createState() => _BottomNavShortcutsState();
}

class _BottomNavShortcutsState extends State<BottomNavShortcuts> {
  int _currentIndex = 1;

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
