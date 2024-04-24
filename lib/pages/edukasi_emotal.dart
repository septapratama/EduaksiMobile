import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/edukasi_emotalArtikel.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:flutter/material.dart';
class EdukasiEmotal extends StatelessWidget {
  EdukasiEmotal({Key? key}) : super(key: key);

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
              title: 'Emotal ( Emosi dan Mental )',
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
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Pengendalian Emosi Dan Mental Pada Anak',
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
                      'Pengendalian emosi dan kesejahteraan mental sangat penting bagi perkembangan anak karena berdampak langsung pada kesehatan mental, hubungan interpersonal, prestasi akademik, resolusi konflik, kemandirian, kecerdasan emosional, serta mencegah perilaku berisiko. Anak-anak yang mampu mengelola emosi dengan baik cenderung lebih sehat secara mental, lebih sukses dalam hubungan sosial, dan lebih fokus dalam belajar, serta memiliki kemampuan untuk mengatasi konflik dan tantangan hidup dengan lebih efektif. Orang tua dan pengasuh memiliki peran kunci dalam memberikan dukungan dan membantu anak-anak mengembangkan keterampilan pengendalian emosi sejak dini.',
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
                      'Dampak negatif kurangnya kesadaran pengendalian emosi dan mental',
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
                      'Kurangnya kesadaran dan pengendalian emosi serta kesejahteraan mental dapat memiliki dampak negatif yang signifikan pada kehidupan seseorang. Hal ini dapat menyebabkan masalah-masalah seperti peningkatan stres, kecemasan, dan depresi. Individu yang tidak mampu mengelola emosi mereka dengan baik cenderung mengalami kesulitan dalam hubungan interpersonal, baik di rumah, sekolah, atau tempat kerja. Selain itu, kurangnya kesadaran akan kesehatan mental dapat mengakibatkan penyalahgunaan zat, perilaku impulsif, dan gangguan perilaku lainnya. Dalam konteks sosial dan profesional, hal ini dapat menghambat kemajuan karier dan menciptakan konflik di lingkungan kerja. Oleh karena itu, kesadaran akan pentingnya pengendalian emosi dan kesejahteraan mental menjadi krusial untuk menjaga keseimbangan dan kualitas hidup yang baik.',
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
                          'Kenapa perlu melakukan pengendalian emosi dan mental',
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
                                'Kesehatan Mental: Mengendalikan emosi membantu mencegah masalah kesehatan mental seperti kecemasan, depresi, dan stres berlebihan.',
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
                                'Hubungan Interpersonal yang Sehat: Kemampuan untuk mengelola emosi dengan baik membantu dalam membangun hubungan yang sehat dengan orang lain, termasuk keluarga, teman, dan rekan kerja.',
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
                                'Kinerja yang Lebih Baik: Orang yang memiliki kesejahteraan mental yang baik cenderung lebih produktif dan fokus dalam kehidupan sehari-hari, baik dalam pekerjaan maupun aktivitas lainnya.',
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
                                'Pengambilan Keputusan yang Lebih Baik: Dengan memiliki kendali atas emosi, seseorang dapat membuat keputusan yang lebih baik secara rasional, tanpa dipengaruhi oleh emosi yang tidak stabil.',
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
                                'Kualitas Hidup yang Lebih Tinggi: Kesejahteraan mental yang baik menyebabkan peningkatan kualitas hidup secara keseluruhan, dengan lebih banyak rasa bahagia, kepuasan, dan keseimbangan.',
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
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tanggal Upload: ${articles[index]['date']}',
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
                  MaterialPageRoute(builder: (context) => EdukasiEmotalartikel()),
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
