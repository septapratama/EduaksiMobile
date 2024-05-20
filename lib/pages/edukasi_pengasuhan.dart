import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/edukasi_pengasuhanArtikel.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:eduapp/pages/pages_detailArtikel.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/material.dart';

class EdukasiPengasuhan extends StatefulWidget {
  EdukasiPengasuhan({super.key});

  @override
  _EdukasiPengasuhanState createState() => _EdukasiPengasuhanState();
}
class _EdukasiPengasuhanState extends State<EdukasiPengasuhan> {
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
      Map<String, dynamic> response = await apiService.getPengasuhan();
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
      print('Error fetching pengasuhan data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: CustomAppBar(
              title: 'Edukasi Pengasuhan',
              buttonOnPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EdukasiMenu()),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/Religi.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Religi',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins_Bold',
                        color: customColor.primaryColors,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Edukasi religius pada anak melibatkan pengajaran nilai-nilai, keyakinan, praktik, dan pengetahuan agama tertentu kepada anak-anak. Ini mencakup memperkenalkan mereka pada ajaran-ajaran agama, etika, dan kebiasaan spiritual yang dapat membentuk karakter dan moralitas mereka.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Divider(
                    height: 38,
                    thickness: 1,
                    color: Colors.grey,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Tujuan',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins_Bold',
                        color: customColor.primaryColors,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Edukasi religius pada anak bertujuan untuk membentuk dasar keimanan yang kuat dan kokoh dalam agama mereka, serta membantu mereka memahami nilai-nilai moral dan etika yang penting dalam kehidupan sehari-hari. Selain itu, melalui pendekatan ini, anak-anak diajak untuk mengembangkan rasa keterhubungan spiritual dengan sesama, alam, dan Tuhan, sambil didorong untuk menunjukkan perilaku positif dan altruistik seperti kepedulian terhadap sesama, belas kasihan, dan toleransi.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Divider(
                    height: 38,
                    thickness: 1,
                    color: Colors.grey,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Kenapa perlu melakukan ni? ',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins_Bold',
                        color: customColor.primaryColors,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Edukasi religius juga membantu anak-anak membangun identitas dan memahami nilai-nilai yang mendasari agama dan kepercayaan mereka, serta memberikan panduan moral yang kuat yang diperlukan saat mereka tumbuh dan berkembang. Selain itu, melalui agama, anak-anak sering kali mendapatkan kenyamanan emosional dan keyakinan untuk menghadapi tantangan dan kesulitan dalam hidup.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Divider(
                    height: 38,
                    thickness: 1,
                    color: Colors.grey,
                    indent: 16,
                    endIndent: 16,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cara Mengatasi ',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins_Bold',
                            color: customColor.primaryColors,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\u2022',
                              style: TextStyle(
                                fontSize: 16,
                                color: customColor.primaryColors,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Berikan contoh yang baik: Jadilah contoh yang baik dalam praktik agama Anda. Anak-anak sering meniru perilaku orang dewasa di sekitar mereka.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\u2022',
                              style: TextStyle(
                                fontSize: 16,
                                color: customColor.primaryColors,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Gunakan metode pembelajaran yang menarik: Gunakan cerita, permainan, atau aktivitas yang menarik untuk mengajar anak-anak tentang agama mereka.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\u2022',
                              style: TextStyle(
                                fontSize: 16,
                                color: customColor.primaryColors,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Buat lingkungan yang mendukung: Ciptakan lingkungan di rumah yang mendukung praktik agama, termasuk waktu untuk berdoa bersama dan membaca kitab suci.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\u2022',
                              style: TextStyle(
                                fontSize: 16,
                                color: customColor.primaryColors,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Ajak anak berdiskusi: Berikan kesempatan kepada anak-anak untuk bertanya dan berdiskusi tentang agama mereka. Dengarkan pertanyaan mereka dengan sabar dan jawab dengan jujur.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\u2022',
                              style: TextStyle(
                                fontSize: 16,
                                color: customColor.primaryColors,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Berikan penguatan positif: Beri pujian dan penghargaan kepada anak-anak ketika mereka menunjukkan minat dan keterlibatan dalam belajar agama.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\u2022',
                              style: TextStyle(
                                fontSize: 16,
                                color: customColor.primaryColors,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Jadikan belajar menyenangkan: Buatlah pengalaman belajar tentang agama menjadi menyenangkan dan menarik dengan menggunakan media visual, permainan peran, atau aktivitas kreatif lainnya.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 38,
                    thickness: 1,
                    color: Colors.grey,
                    indent: 16,
                    endIndent: 16,
                  ),
                ],
              ),
            ),
          ),

          // Bagian implementasi list artikel
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Artikel Pendukung',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailArtikel(detailData: {'id_data':articles[index]['id_data'], 'table': 'pengasuhan'})));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Card(
                            elevation: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  '${apiService.imgUrl}/pengasuhan/${articles[index]['gambar']}',
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
        SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                // Navigasi ke halaman lain saat "Lihat Lainnya" diklik
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EdukasiPengasuhanartikel()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey[200],
                child: const Center(
                  child: Text(
                    'Lihat Lainnya',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Atur warna teks sesuai keinginan
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
