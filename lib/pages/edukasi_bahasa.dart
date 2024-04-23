import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/edukasi_bahasaArtikel.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:flutter/material.dart';

class BahasaPages extends StatelessWidget {
  BahasaPages({Key? key});

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
              title: 'Edukasi Bahasa',
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
                    'assets/images/bahasa.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Bahasa',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins_Bold',
                        color: customColor.primaryColors,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Mengajari bahasa atau kecakapan berbicara pada anak merupakan cabang psikologi perkembangan yang berkaitan dengan bagaimana anak-anak belajar, memahami, dan menggunakan bahasa. Ini melibatkan pemahaman tentang perkembangan bahasa anak, proses belajar bicara, dan faktor-faktor yang memengaruhi kemampuan berkomunikasi mereka.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Divider(
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
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Membantu anak-anak mengembangkan kemampuan berbicara dan berkomunikasi secara efektif. Ini termasuk memahami arti kata-kata, mempelajari tata bahasa yang tepat, dan belajar berinteraksi dengan orang lain dalam konteks sosial yang berbeda.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Divider(
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
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Kecakapan dalam berbicara adalah keterampilan yang sangat penting dalam kehidupan sehari-hari. Kemampuan berkomunikasi yang baik memungkinkan anak untuk mengekspresikan pikiran, perasaan, dan kebutuhan mereka dengan jelas, yang dapat meningkatkan kualitas hubungan sosial dan akademik mereka. Selain itu, kemampuan berbicara yang baik juga mempersiapkan anak untuk sukses di sekolah dan di tempat kerja di masa depan.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Divider(
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
                        SizedBox(height: 5),
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
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Stimulasi Bahasa: Berikan anak lingkungan yang kaya akan bahasa dengan membacakan buku, menyanyikan lagu, dan berbicara dengannya secara teratur.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
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
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Modelkan Kecakapan Berbicara: Jadilah contoh yang baik dengan menggunakan bahasa yang baik dan benar di depan anak. Berbicaralah dengan tenang dan jelas, dan beri mereka contoh kalimat yang benar.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
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
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Ajarkan Melalui Interaksi Sosial: Ajak anak untuk berinteraksi dengan orang lain secara aktif. Melalui percakapan dan interaksi sosial, mereka akan belajar untuk memahami cara menggunakan bahasa dengan baik.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
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
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Berikan Umpan Balik Positif: Berikan pujian dan dorongan saat anak menggunakan bahasa dengan baik. Ini akan memperkuat perilaku yang diinginkan dan meningkatkan kepercayaan diri mereka dalam berbicara.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
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
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Terlibat dalam Kegiatan Berbicara yang Menarik: Ajak anak untuk berpartisipasi dalam permainan kata, teka-teki, atau cerita bersama untuk meningkatkan kemampuan berbicara mereka secara menyenangkan dan interaktif.el Perilaku Positif: Orang tua dan pengasuh perlu menjadi contoh yang baik dalam mengelola emosi mereka sendiri. Anak-anak belajar banyak dari pengamatan terhadap bagaimana orang dewasa merespon situasi yang menantang.',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
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
                  Text(
                    'Artikel Pendukung',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
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
          // Tambahkan widget InkWell untuk "Lihat Lainnya" di sini
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                // Navigasi ke halaman lain saat "Lihat Lainnya" diklik
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BahasaArtikel()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey[200],
                child: Center(
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
