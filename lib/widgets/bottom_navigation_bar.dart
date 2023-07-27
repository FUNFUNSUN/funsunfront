import 'package:flutter/material.dart';
import 'package:funsunfront/screens/bottom_nav_shortcuts.dart';

class BtmNavBarWidget extends StatelessWidget {
  const BtmNavBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? iconColorForNotSelected = Colors.grey[600];
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            color: iconColorForNotSelected,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavShortcuts(
                    initIndex: 0,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            color: iconColorForNotSelected,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavShortcuts(
                    initIndex: 1,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            color: iconColorForNotSelected,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavShortcuts(
                    initIndex: 2,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
