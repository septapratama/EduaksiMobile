import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/aksi_calculator.dart';
import 'package:eduapp/pages/aksi_calendar_old.dart';
import 'package:eduapp/pages/edukasi_emotal.dart';
import 'package:eduapp/pages/edukasi_diisi.dart';
import 'package:eduapp/pages/edukasi_nutrisi.dart';
import 'package:eduapp/pages/riwayatCalendar.dart';
import 'package:eduapp/utils/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_appbar_withoutarrowback.dart';

class AksiMenu extends StatelessWidget {
  AksiMenu({super.key});

  List<Map<String, dynamic>> articles = [
    {
      'title': 'Tentukan Berat Badan Ideal Anda',
      'image': 'assets/images/artikel 1.png',
    },
    {
      'title': 'Catat Tumbuh Kembang Anak',
      'image': 'assets/images/image 36.png',
    },
    // Add more articles as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Aksi',
        buttonOnPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BottomNav()));
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fitur Aksi Memudahkan Anda',
                    style: TextStyle(
                      fontFamily: 'Poppins_Bold',
                      fontSize: 24,
                      color: customColor.primaryColors,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Temukan Hal Menarik Disini',
                    style: TextStyle(
                      fontFamily: 'Poppins_Regular',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 20),
                    child: Card(
                      color: customColor.cardcustom,
                      child: InkWell(
                        onTap: () {
                          // Implementasi fungsionalitas yang Anda inginkan di sini
                          // Navigasi ke halaman berbeda tergantung pada index atau jenis artikel
                          if (index == 0) {
                            // Jika index pertama, navigasi ke PsikologiPages
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Calculator(),
                              ),
                            );
                          } else if (index == 1) {
                            // Jika index kedua, navigasi ke BahasaPages
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RiwayatCalendar(),
                              ),
                            );
                          } 
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                bottomLeft: Radius.circular(4.0),
                              ),
                              child: Image.asset(
                                articles[index]['image'],
                                width: 135,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Flexible(
                              child: ListTile(
                                title: Text(
                                  articles[index]['title'],
                                  style: TextStyle(
                                    color: customColor.primaryColors,
                                    fontFamily: 'Poppins_Bold',
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Add more widgets for your content here
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;

  const DetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Detail page for $title'),
      ),
    );
  }
}
