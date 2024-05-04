import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/edukasi_bahasa.dart';
import 'package:eduapp/pages/edukasi_kesenian.dart';
import 'package:eduapp/pages/edukasi_psikologi.dart';
import 'package:eduapp/pages/edukasi_religi.dart';
import 'package:eduapp/utils/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_appbar_withoutarrowback.dart';

class EdukasiMenu extends StatelessWidget {
  EdukasiMenu({super.key});

  List<Map<String, dynamic>> articles = [
    {
      'title': 'Edukasi Psikologi',
      'image': 'assets/images/artikel 1.png',
    },
    {
      'title': 'Edukasi Bahasa',
      'image': 'assets/images/image 36.png',
    },
    {
      'title': 'Edukasi Religi',
      'image': 'assets/images/image 34.png',
    },
    {
      'title': 'Edukasi Kesenian',
      'image': 'assets/images/image 35.png',
    },
    // Add more articles as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edukasi',
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
                    'Topik Populer EduAksi',
                    style: TextStyle(
                      fontFamily: 'Poppins_Bold',
                      fontSize: 24,
                      color: customColor.primaryColors,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Pemahaman untuk kebutuhan anak sedari dini',
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
                                builder: (context) => PskikologiPages(),
                              ),
                            );
                          } else if (index == 1) {
                            // Jika index kedua, navigasi ke BahasaPages
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BahasaPages(),
                              ),
                            );
                          } else if (index == 2) {
                            // Jika index kedua, navigasi ke BahasaPages
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReligiPages(),
                              ),
                            );
                          }
                          else if (index == 3) {
                            // Jika index kedua, navigasi ke BahasaPages
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KesenianPages(),
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
                            child: Image.asset(
                              articles[index]['image'],
                              width: 120,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Flexible(
                            child: ListTile(
                              title: Text(
                                articles[index]['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins_Bold',
                                  fontSize: 17,
                                ),
                              ),
                              subtitle: Text(
                                articles[index]['date'],
                                style: TextStyle(
                                  fontFamily: 'Poppins_SemiBold',
                                  fontSize: 12,
                                ),
                              ),
                              onTap: () {
                                // Implementasi penanganan ketika item diklik (navigasi ke halaman detail, misalnya)
                              },
                            ),
                          ),
                        ],
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

  const DetailPage({Key? key, required this.title}) : super(key: key);

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
