import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:flutter/material.dart';

class PskikologiPages extends StatelessWidget {
  const PskikologiPages({Key? key});

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
                    'assets/images/Psiko.jpg', // Ganti 'your_image.png' dengan nama dan path gambar Anda
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  SizedBox(height: 16), // Jarak antara gambar dan teks
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Jarak antara judul dan deskripsi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi emosional anak dapat diketahui bagaimana anak-anak mengenali, mengelola, dan bereaksi terhadap emosi mereka sendiri serta emosi orang lain. Ini meliputi pemahaman tentang berbagai emosi seperti kegembiraan, kecemasan, kemarahan, kesedihan, dan bagaimana emosi ini mempengaruhi perilaku dan interaksi sosial anak.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Jarak antara judul dan deskripsi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi emosional anak dapat diketahui bagaimana anak-anak mengenali, mengelola, dan bereaksi terhadap emosi mereka sendiri serta emosi orang lain. Ini meliputi pemahaman tentang berbagai emosi seperti kegembiraan, kecemasan, kemarahan, kesedihan, dan bagaimana emosi ini mempengaruhi perilaku dan interaksi sosial anak.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Jarak antara judul dan deskripsi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi emosional anak dapat diketahui bagaimana anak-anak mengenali, mengelola, dan bereaksi terhadap emosi mereka sendiri serta emosi orang lain. Ini meliputi pemahaman tentang berbagai emosi seperti kegembiraan, kecemasan, kemarahan, kesedihan, dan bagaimana emosi ini mempengaruhi perilaku dan interaksi sosial anak.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Jarak antara judul dan deskripsi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi emosional anak dapat diketahui bagaimana anak-anak mengenali, mengelola, dan bereaksi terhadap emosi mereka sendiri serta emosi orang lain. Ini meliputi pemahaman tentang berbagai emosi seperti kegembiraan, kecemasan, kemarahan, kesedihan, dan bagaimana emosi ini mempengaruhi perilaku dan interaksi sosial anak.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Jarak antara judul dan deskripsi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi emosional anak dapat diketahui bagaimana anak-anak mengenali, mengelola, dan bereaksi terhadap emosi mereka sendiri serta emosi orang lain. Ini meliputi pemahaman tentang berbagai emosi seperti kegembiraan, kecemasan, kemarahan, kesedihan, dan bagaimana emosi ini mempengaruhi perilaku dan interaksi sosial anak.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Jarak antara judul dan deskripsi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Psikologi emosional anak dapat diketahui bagaimana anak-anak mengenali, mengelola, dan bereaksi terhadap emosi mereka sendiri serta emosi orang lain. Ini meliputi pemahaman tentang berbagai emosi seperti kegembiraan, kecemasan, kemarahan, kesedihan, dan bagaimana emosi ini mempengaruhi perilaku dan interaksi sosial anak.',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  
                  // Tambahkan konten lainnya di sini
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
