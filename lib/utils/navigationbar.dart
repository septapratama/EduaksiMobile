import 'package:eduapp/component/custom_colors.dart';
import 'package:flutter/material.dart';

class navigationbar extends StatefulWidget {
  @override
  _navigationbarstate createState() => _navigationbarstate();
}

class _navigationbarstate extends State<navigationbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Demo'),
      ),
      body: Center(
        child: Text(
          'Selected Index: $_selectedIndex',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors
            .red, // Change this color to the desired background color/ Change this color to the desired color
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: customColor.selectednavbar,
        unselectedItemColor: customColor.unselectednavbar,
        items: [
          BottomNavigationBarItem(
            backgroundColor: customColor.bottomnavigationColors,
            icon: Image.asset('assets/images/ant-design_home-filled.png',
                width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: customColor.bottomnavigationColors,
            icon: Image.asset('assets/images/ant-design_home-filled.png',
                width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: customColor.bottomnavigationColors,
            icon: Image.asset('assets/images/ant-design_home-filled.png',
                width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: customColor.bottomnavigationColors,
            icon: Image.asset('assets/images/ant-design_home-filled.png',
                width: 24, height: 24),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
