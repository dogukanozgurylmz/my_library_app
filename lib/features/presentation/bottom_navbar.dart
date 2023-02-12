import 'package:flutter/material.dart';

import '../data/datasource/mylibrary_auth.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      backgroundColor: colorScheme.onBackground,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
      selectedLabelStyle: textTheme.caption,
      unselectedLabelStyle: textTheme.caption,
      iconSize: 24,
      onTap: (value) {
        setState(() => _currentIndex = value);
      },
      items: const [
        BottomNavigationBarItem(label: '', icon: Icon(Icons.home_rounded)
            // Image.asset(
            //   "assets/images/mylibrarylogo.png",
            //   height: 24,
            //   width: 24,
            // ),
            ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.auto_awesome_motion_rounded),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
