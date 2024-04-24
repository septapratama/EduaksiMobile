import 'package:eduapp/pages/beranda_LihatArticles.dart';
import 'package:eduapp/pages/edukasi_nutrisi.dart';
import 'package:eduapp/pages/konsultasi.dart';
import 'package:eduapp/pages/pages_AksiMenu.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:eduapp/pages/pages_profil.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_colors.dart';

class Beranda extends StatelessWidget {
  Beranda({super.key});

  List menu = [
    "Edukasi",
    "Aksi",
    "Konsultasi",
  ];
  List<Color> menuColors = [
    const Color.fromARGB(255, 7, 159, 229),
    const Color.fromARGB(255, 222, 107, 6),
    const Color.fromARGB(255, 3, 181, 86),
  ];

  List<Icon> menuIcons = [
    const Icon(Icons.school, color: Colors.white, size: 30),
    const Icon(Icons.camera, color: Colors.white, size: 30),
    const Icon(Icons.phone_in_talk, color: Colors.white, size: 30),
  ];

  List<Map<String, dynamic>> articles = [
    {
      'title': 'Judul Artikel 1',
      'date': '29 Maret 2024',
      'image': 'assets/images/artikel 1.png',
    },
    {
      'title': 'Judul Artikel 2',
      'date': '28 Maret 2024',
      'image': 'assets/images/artikel 2.png',
    },
    {
      'title': 'Judul Artikel 2',
      'date': '28 Maret 2024',
      'image': 'assets/images/artikel 2.png',
    },
    {
      'title': 'Judul Artikel 2',
      'date': '28 Maret 2024',
      'image': 'assets/images/artikel 2.png',
    },
    {
      'title': 'Judul Artikel 2',
      'date': '28 Maret 2024',
      'image': 'assets/images/artikel 2.png',
    },
    // Add more articles as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: customColor.primaryColors,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: 30,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 15),
                    child: Text(
                      "SUP, HOMIESSS",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Poppins_Bold',
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 11,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                GridView.builder(
                  itemCount: menu.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Perform navigation based on the index or menu item clicked
                        switch (index) {
                          case 0:
                            // Navigate to EdukasiPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EdukasiMenu()), // Replace EdukasiPage() with your actual page widget
                            );
                            break;
                          case 1:
                            // Navigate to AksiPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AksiMenu()), // Replace AksiPage() with your actual page widget
                            );
                            break;
                          case 2:
                            // Navigate to KonsultasiPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Konsultasi()), // Replace KonsultasiPage() with your actual page widget
                            );
                            break;
                          default:
                            break;
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              color: menuColors[index],
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: menuIcons[index]),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            menu[index],
                            style:  TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins_SemiBold',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Divider(
                    height: 5,
                    thickness: 3,
                    color: customColor.primaryColors,
                    indent: 18,
                    endIndent: 18,
                  ),

                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Artikel Terbaru",
                      style:
                          TextStyle(fontSize: 16, fontFamily: 'Poppins_Bold'),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the page you want when "Lihat Semua" is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BerandaLihatarticles()),
                        );
                      },
                      child:  Text(
                        "Lihat Semua",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins_Bold',
                          color: customColor.primaryColors, // Change color as needed
                        ),
                      ),
                    ),
                  ],
                ),

                // const SizedBox(height: 10),
                // Article List
                ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var article = articles[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          // Implementasi penanganan ketika item diklik (navigasi ke halaman detail, misalnya)
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(10)),
                              child: Image.asset(
                                article['image'],
                                width: 135,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article['title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins_Bold',
                                        fontSize: 17,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      article['date'],
                                      style: const TextStyle(
                                        fontFamily: 'Poppins_SemiBold',
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
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
        ],
      ),
    );
  }
}
