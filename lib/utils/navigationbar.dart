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
  final List<Widget> body = [Beranda(), EdukasiMenu(), ProfilPages()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: ontap,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: customColor.gray),
              label: 'Home',
              activeIcon:
                  Icon(Icons.home, color: customColor.bottomnavigationColors)),
          BottomNavigationBarItem(
              icon: Icon(Icons.child_care, color: customColor.gray),
              label: 'Konseling',
              activeIcon: Icon(Icons.child_care,
                  color: customColor.bottomnavigationColors)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: customColor.gray),
              label: 'Profil',
              activeIcon: Icon(Icons.person,
                  color: customColor.bottomnavigationColors)),
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
