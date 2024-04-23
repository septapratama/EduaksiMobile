import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/edukasi_psikologiArtikel.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:flutter/material.dart';

class PskikologiPages extends StatelessWidget {
  PskikologiPages({Key? key});

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
              title: 'Edukasi Psikologi',
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
                    'assets/images/Psiko.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi',
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
                      'Psikologi emosional anak dapat diketahui bagaimana anak-anak mengenali, mengelola, dan bereaksi terhadap emosi mereka sendiri serta emosi orang lain. Ini meliputi pemahaman tentang berbagai emosi seperti kegembiraan, kecemasan, kemarahan, kesedihan, dan bagaimana emosi ini mempengaruhi perilaku dan interaksi sosial anak.',
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
                      'Membantu anak mengembangkan keterampilan pengaturan emosi yang sehat, termasuk kemampuan untuk mengidentifikasi emosi, mengelola stres, memahami dan mengkomunikasikan perasaan mereka, serta membangun hubungan sosial yang positif.',
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
                      'Pemahaman dan pengaturan emosional anak sangat penting untuk perkembangan holistik mereka. Kemampuan untuk mengelola emosi dengan baik membantu anak dalam berbagai aspek kehidupan mereka, termasuk prestasi akademis, hubungan sosial, dan kesejahteraan mental. Anak-anak yang memiliki keterampilan pengaturan emosi yang baik cenderung lebih mampu menyelesaikan konflik, lebih terampil dalam berempati, dan lebih mudah beradaptasi dengan perubahan.',
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
                                'Model Perilaku Positif: Orang tua dan pengasuh perlu menjadi contoh yang baik dalam mengelola emosi mereka sendiri. Anak-anak belajar banyak dari pengamatan terhadap bagaimana orang dewasa merespon situasi yang menantang.',
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
                                'Mengajarkan Penyadaran Emosional: Bantu anak untuk mengidentifikasi dan memahami emosi mereka sendiri dengan memberikan nama pada emosi yang mereka rasakan. Ajari mereka untuk mengenali tanda-tanda fisik emosi seperti detak jantung yang cepat ketika marah atau perasaan getaran di perut ketika cemas.',
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
                                'Membangun Keterampilan Pengaturan Emosi: Ajarkan anak teknik-teknik relaksasi seperti pernapasan dalam dan latihan visualisasi untuk membantu mereka mengatasi stres dan kecemasan. Berikan strategi praktis untuk mengatasi kemarahan seperti mengambil napas dalam-dalam atau berjalan-jalan sebentar.',
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
                                'Komunikasi Terbuka: Jadikan rumah sebagai tempat yang aman bagi anak untuk mengungkapkan perasaan mereka. Dengan mendengarkan dengan empati dan tanpa penilaian, anak akan merasa didukung dan lebih nyaman dalam berbagi perasaan mereka.',
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
                                'Membangun Koneksi Emosional: Luangkan waktu untuk terhubung secara emosional dengan anak Anda melalui kegiatan yang Anda nikmati bersama, seperti membaca buku, bermain permainan, atau sekadar berbicara satu sama lain. Hubungan yang kuat dengan orang tua atau pengasuh membantu anak merasa aman dan didukung dalam mengelola emosinya.',
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
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                // Navigasi ke halaman lain saat "Lihat Lainnya" diklik
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PsikoArtikel()),
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
