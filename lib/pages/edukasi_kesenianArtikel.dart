import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/pages/edukasi_psikologi.dart';
import 'package:flutter/material.dart';

class KesenianArtikel extends StatelessWidget {
  KesenianArtikel({super.key});
  // Dummy list of articles
  final List<Map<String, String>> articles = [
    {
      'title': 'Model Perilaku Positif',
      'date': '29 Maret 2024',
      'image': 'assets/images/artikel 1.png',
    },
    {
      'title': 'Mengajarkan Penyadaran Emosional',
      'date': '28 Maret 2024',
      'image': 'assets/images/artikel 2.png',
    },
    {
      'title': 'Membangun Keterampilan Pengaturan Emosi',
      'date': '28 Maret 2024',
      'image': 'assets/images/artikel 1.png',
    },
    
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
                  MaterialPageRoute(builder: (context) => PskikologiPages()),
                );
              },
            ),
          ),
           // Bagian implementasi list artikel
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ 
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                articles[index]['image']!,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      articles[index]['title']!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Tanggal Upload: ${articles[index]['date']}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}