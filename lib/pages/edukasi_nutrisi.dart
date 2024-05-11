import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/edukasi_nutrisiArtikel.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/material.dart';

class EdukasiNutrisi extends StatefulWidget {
  EdukasiNutrisi({super.key});

  @override
  _EdukasiNutrisiState createState() => _EdukasiNutrisiState();
}
class _EdukasiNutrisiState extends State<EdukasiNutrisi> {
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
      Map<String, dynamic> response = await apiService.getNutrisi();
      if (response['status'] == 'success') {
        setState(() {
          articles = List<Map<String, dynamic>>.from(response['data']['artikel']);
        });

      } else {
        //do something
      }
    } catch (e) {
      print('Error fetching nutrisi data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: CustomAppBar(
              title: 'Edukasi Nutrisi',
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
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi emosional anak dapat diketahui bagaimana anak-anak mengenali, mengelola, dan bereaksi terhadap emosi mereka sendiri serta emosi orang lain. Ini meliputi pemahaman tentang berbagai emosi seperti kegembiraan, kecemasan, kemarahan, kesedihan, dan bagaimana emosi ini mempengaruhi perilaku dan interaksi sosial anak.',
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
                      'Membantu anak mengembangkan keterampilan pengaturan emosi yang sehat, termasuk kemampuan untuk mengidentifikasi emosi, mengelola stres, memahami dan mengkomunikasikan perasaan mereka, serta membangun hubungan sosial yang positif.',
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
                      'Pemahaman dan pengaturan emosional anak sangat penting untuk perkembangan holistik mereka. Kemampuan untuk mengelola emosi dengan baik membantu anak dalam berbagai aspek kehidupan mereka, termasuk prestasi akademis, hubungan sosial, dan kesejahteraan mental. Anak-anak yang memiliki keterampilan pengaturan emosi yang baik cenderung lebih mampu menyelesaikan konflik, lebih terampil dalam berempati, dan lebih mudah beradaptasi dengan perubahan.',
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
                                'Model Perilaku Positif: Orang tua dan pengasuh perlu menjadi contoh yang baik dalam mengelola emosi mereka sendiri. Anak-anak belajar banyak dari pengamatan terhadap bagaimana orang dewasa merespon situasi yang menantang.',
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
                                'Mengajarkan Penyadaran Emosional: Bantu anak untuk mengidentifikasi dan memahami emosi mereka sendiri dengan memberikan nama pada emosi yang mereka rasakan. Ajari mereka untuk mengenali tanda-tanda fisik emosi seperti detak jantung yang cepat ketika marah atau perasaan getaran di perut ketika cemas.',
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
                                'Membangun Keterampilan Pengaturan Emosi: Ajarkan anak teknik-teknik relaksasi seperti pernapasan dalam dan latihan visualisasi untuk membantu mereka mengatasi stres dan kecemasan. Berikan strategi praktis untuk mengatasi kemarahan seperti mengambil napas dalam-dalam atau berjalan-jalan sebentar.',
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
                                'Komunikasi Terbuka: Jadikan rumah sebagai tempat yang aman bagi anak untuk mengungkapkan perasaan mereka. Dengan mendengarkan dengan empati dan tanpa penilaian, anak akan merasa didukung dan lebih nyaman dalam berbagi perasaan mereka.',
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
                                'Membangun Koneksi Emosional: Luangkan waktu untuk terhubung secara emosional dengan anak Anda melalui kegiatan yang Anda nikmati bersama, seperti membaca buku, bermain permainan, atau sekadar berbicara satu sama lain. Hubungan yang kuat dengan orang tua atau pengasuh membantu anak merasa aman dan didukung dalam mengelola emosinya.',
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
                              Image.network(
                                '${apiService.imgUrl}/artikel/${articles[index]['gambar']}',
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
                  MaterialPageRoute(builder: (context) => EdukasiNutrisiartikel()),
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
