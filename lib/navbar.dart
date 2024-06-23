import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:work_corner/ColorPalete.dart';

class NavBar extends StatefulWidget {
  final ValueChanged<int> onTap; 
  const NavBar({super.key, required this.onTap});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: ColorPalete().color1,
      items: [
        Icon(
          Icons.home,
          size: 26,
          color: Colors.white,
        ),
        Icon(
          Icons.message,
          size: 26,
          color: Colors.white,
        ),
        Icon(
          Icons.notifications,
          size: 26,
          color: Colors.white,
        ),
        Icon(
          Icons.person,
          size: 26,
          color: Colors.white,
        ),
      ],
      onTap: (index) => widget.onTap(index),
      backgroundColor: Colors.white,
      buttonBackgroundColor: ColorPalete().color1,
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
