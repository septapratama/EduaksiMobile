import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_appbar_withoutarrowback.dart';

class EdukasiMenu extends StatelessWidget {
  EdukasiMenu({super.key});

  List<Map<String, dynamic>> articles = [
    {
      'title': 'Judul Artikel 1',
      'date': '29 Maret 2024',
      'image': 'assets/images/artikel 1.png',
    },
    {
      'title': 'Judul Artikel 2',
      'date': '28 Maret 2024',
      'image': 'assets/images/image 36.png',
    },
    {
      'title': 'Judul Artikel 2',
      'date': '28 Maret 2024',
      'image': 'assets/images/image 34.png',
    },
    {
      'title': 'Judul Artikel 2',
      'date': '28 Maret 2024',
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
                      color: Colors.grey[200],
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              bottomLeft: Radius.circular(4.0),
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
