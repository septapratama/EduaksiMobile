import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/edukasi_diisiArtikel.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:flutter/material.dart';

class EdukasiDiisi extends StatelessWidget {
  EdukasiDiisi({super.key});

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
              title: 'DIISI ( Digital Literasi )',
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset(
                'assets/images/Kesenian.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Digital Literasi',
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
                  'Digital literasi adalah kemampuan untuk menggunakan teknologi digital dengan baik dan bertanggung jawab. Ini mencakup cara menggunakan perangkat seperti komputer dan ponsel cerdas, menilai informasi online dengan kritis, berkolaborasi secara daring, dan menjaga keamanan serta privasi dalam beraktivitas digital. Dengan digital literasi yang baik, seseorang dapat lebih efisien dalam memanfaatkan teknologi dalam berbagai aspek kehidupan sehari-hari.',
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
                  'Tujuan Digital Literasi',
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
                  'Tujuan dari digital literasi adalah untuk memberdayakan individu agar dapat berfungsi secara efektif dalam masyarakat yang semakin tergantung pada teknologi digital. Dengan keterampilan tersebut, seseorang dapat berpartisipasi aktif dalam masyarakat digital, mengakses informasi dengan efisien, mengembangkan keterampilan profesional, menjaga keamanan dan privasi online, serta meningkatkan akses ke peluang pendidikan dan ekonomi. Digital literasi memainkan peran penting dalam memungkinkan individu untuk mengambil manfaat maksimal dari teknologi dan beradaptasi dengan perubahan yang terus berlangsung dalam era digital.',
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
                      'Hal yang perlu dihindari',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins_Bold',
                        color: customColor.primaryColors,
                      ),
                    ),
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
                            'Penyebaran Informasi Palsu: Hindari menyebarkan informasi yang tidak terverifikasi atau hoaks yang dapat menyebabkan kebingungan atau kepanikan di masyarakat.',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
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
                            'Pelanggaran Privasi: Jaga privasi pribadi dan hindari membagikan informasi sensitif secara tidak tepat, baik itu dalam bentuk data pribadi atau informasi lainnya yang dapat membahayakan diri sendiri atau orang lain.',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
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
                            'Cyberbullying: Hindari berpartisipasi dalam perilaku cyberbullying atau mengintimidasi orang lain secara daring, serta belajar untuk berkomunikasi secara online dengan sopan dan menghormati.',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
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
                            'Ketergantungan Berlebihan pada Teknologi: Jagalah keseimbangan antara waktu yang dihabiskan secara online dan offline, hindari ketergantungan yang berlebihan pada perangkat digital, dan luangkan waktu untuk berinteraksi secara langsung dengan dunia nyata.',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
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
                            'Piranti dan Konten yang Merugikan: Hindari mengakses atau menggunakan piranti atau konten yang merugikan atau ilegal seperti situs web berbahaya, aplikasi penipuan, atau konten yang tidak pantas.',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
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
                            'Ketidakamanan Online: Jauhi praktik-praktik yang dapat membahayakan keamanan online seperti mengklik tautan yang mencurigakan, mengunduh file dari sumber yang tidak terpercaya, atau menggunakan kata sandi yang lemah.',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
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
                            'Bentengi Anak dengan hal berikut',
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
                                  'Pendidikan dan Kesadaran: Ajarkan anak tentang pentingnya digital literasi dan bahaya yang mungkin terjadi dalam penggunaan teknologi. Berikan informasi tentang privasi online, keamanan, dan cara-cara untuk mengidentifikasi informasi yang dapat dipercaya di internet.',
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
                                  'Pengawasan dan Pembatasan: Awasi aktivitas anak secara online dan tetapkan pembatasan yang sesuai dengan usia mereka terkait dengan waktu layar, akses ke konten tertentu, dan interaksi dengan orang asing di internet.',
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
                                  'Pendidikan Etika Digital: Ajarkan anak tentang etika digital, termasuk bagaimana berinteraksi secara sopan di media sosial, menghormati privasi orang lain, dan tidak melakukan perilaku cyberbullying atau intimidasi online.',
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
                                  'Pembelajaran Kolaboratif: Libatkan anak dalam kegiatan pembelajaran kolaboratif yang mendorong penggunaan teknologi secara kreatif dan produktif, seperti membuat konten digital, berpartisipasi dalam proyek bersama, atau mempelajari keterampilan baru secara daring.',
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
                                  'Model Perilaku Positif: Jadilah teladan bagi anak dalam penggunaan teknologi. Tunjukkan cara yang baik dalam berkomunikasi online, menilai informasi secara kritis, dan mengelola waktu secara seimbang antara kegiatan online dan offline.',
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
                                  'Komunikasi Terbuka: Buatlah suasana di mana anak merasa nyaman untuk berbicara tentang pengalaman mereka secara online. Dorong mereka untuk bertanya dan berbagi jika mereka menghadapi situasi atau pertanyaan yang membingungkan atau tidak aman.',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
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
                                  'Pemantauan dan Pemantapan: Teruslah memantau perkembangan anak dalam penggunaan teknologi dan berikan penguatan positif serta arahan jika diperlukan. Selalu tersedia untuk menjawab pertanyaan mereka dan memberikan bimbingan saat diperlukan.',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ]),
          )),

          // Bagian implementasi list artikel
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
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
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                // Navigasi ke halaman lain saat "Lihat Lainnya" diklik
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EdukasiDiisiartikel()),
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
