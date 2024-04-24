import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/utils/navigationbar.dart';
import 'package:flutter/material.dart';

class Konsultasi extends StatelessWidget {
   Konsultasi({super.key});

  // Data dummy untuk dokter
  final List<Map<String, String>> doctors = [
    {
      'name': 'Septia Rahma Dwi P, S.Psi',
      'specialty': 'Psikolog Anak',
      'image': 'assets/images/logo_eyes.png'
    },
    {
      'name': 'Septia Rahma Dwi P, S.Psi',
      'specialty': 'Psikolog Anak',
      'image': 'assets/images/logo_eyes.png'
    },
     {
      'name': 'Septia Rahma Dwi P, S.Psi',
      'specialty': 'Psikolog Anak',
      'image': 'assets/images/logo_eyes.png'
    },
    // Tambahkan lebih banyak dokter di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: CustomAppBar(
              title: 'Artikel Edukasi Psikologi',
              buttonOnPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNav()),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Temukan Ahli Spesialismu........',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var doctor = doctors[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: customColor.primaryColors,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(doctor['image']!),
                        radius: 30,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(doctor['name']!, style: TextStyle(fontFamily: 'Poppins_Bold', color: Colors.white)),
                            Text(doctor['specialty']!, style: TextStyle(fontFamily: 'Poppins_Bold', color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: doctors.length,
            ),
          ),
        ],
      ),
    );
  }
}