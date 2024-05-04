import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/pages/edukasi_psikologi.dart';
import 'package:flutter/material.dart';

class BahasaArtikel extends StatelessWidget {
  BahasaArtikel({super.key});
  // Dummy list of articles
  // final List<Map<String, String>> articles = [
  //   {
  //     'judul': 'Model Perilaku Positif',
  //     'created_at': '29 Maret 2024',
  //     'foto': 'assets/images/artikel 1.png',
  //   },
  //   {
  //     'judul': 'Mengajarkan Penyadaran Emosional',
  //     'created_at': '28 Maret 2024',
  //     'foto': 'assets/images/artikel 2.png',
  //   },
  //   {
  //     'judul': 'Membangun Keterampilan Pengaturan Emosi',
  //     'created_at': '28 Maret 2024',
  //     'foto': 'assets/images/artikel 1.png',
  //   },
    
  // ];
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    try {
      Map<String, dynamic> response = await apiService.getArtikel();
      if (response['status'] == 'success') {
        setState(() { 
          articles = List<Map<String, dynamic>>.from(response['data']);
        });

      } else {
        //do something
      }
    } catch (e) {
      print('Error fetching artikel data: $e');
    }
  }

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
                      var article = articles[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                '${apiService.imgUrl}/artikel/${article['foto']}',
                                width: 135,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  print('Error loading image:${error}');
                                  return Image.asset(
                                    'assets/images/artikel 1.png',  
                                    width: 135,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  );
                                },
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