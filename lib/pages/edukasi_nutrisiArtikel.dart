import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/pages/edukasi_nutrisi.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/pages/pages_detailArtikel.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/material.dart';

class EdukasiNutrisiartikel extends StatefulWidget {
  EdukasiNutrisiartikel({super.key});

  @override
  _EdukasiNutrisiartikelState createState() => _EdukasiNutrisiartikelState();
}
class _EdukasiNutrisiartikelState extends State<EdukasiNutrisiartikel> {
  final ApiService apiService = ApiService();
  final String artikelNotFound = 'assets/images/artikel 1.png';
  List<Map<String, dynamic>> articles = [];
  // Dummy list of articles
  // final List<Map<String, String>> articles = [
  //   {
  //     'judul': 'Model Perilaku Positif',
  //     'tanggal': '29 Maret 2024',
  //     'gambar': 'assets/images/artikel 1.png',
  //   },
  //   {
  //     'judul': 'Mengajarkan Penyadaran Emosional',
  //     'tanggal': '28 Maret 2024',
  //     'gambar': 'assets/images/artikel 2.png',
  //   },
  //   {
  //     'judul': 'Membangun Keterampilan Pengaturan Emosi',
  //     'tanggal': '28 Maret 2024',
  //     'gambar': 'assets/images/artikel 1.png',
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    try {
      Map<String, dynamic> response = await apiService.getNutrisiArtikel();
      if (response['status'] == 'success') {
        setState(() {
          articles = List<Map<String, dynamic>>.from(response['data']);
        });

      } else {
        String errRes = response['message'].toString();
        if(errRes.contains('login') || errRes.contains('expired')){
          Future.delayed(const Duration(seconds: 2), () {
            return Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen()));
          });
        }
      }
    } catch (e) {
      print('Error fetching nutrisi artikel data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: CustomAppBar(
              title: 'Artikel Edukasi Nutrisi',
              buttonOnPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EdukasiNutrisi()),
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailArtikel(detailData: {'id_data':articles[index]['id_data'], 'table': 'nutrisi'})));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Card(
                            elevation: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  '${apiService.imgUrl}/nutrisi/${articles[index]['gambar']}',
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    print('Error loading image:${error}');
                                    return Image.asset(
                                      artikelNotFound,
                                      width: 135,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      // fit: BoxFit.contain,
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        articles[index]['judul']!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Tanggal Upload: ${articles[index]['tanggal']}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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