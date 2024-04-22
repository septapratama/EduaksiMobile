import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/beranda_pages.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:eduapp/pages/pages_profil.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  final List<Widget> body = [Beranda(), ProfilPages()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: ontap,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, color: customColor.gray),
              label: 'Home',
              activeIcon:
                  Icon(Icons.home_rounded, color: customColor.primaryColors)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded, color: customColor.gray),
              label: 'Profil',
              activeIcon: Icon(Icons.person_2_rounded,
                  color: customColor.primaryColors)),
        ],
      ),
    );
  }

  void ontap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
