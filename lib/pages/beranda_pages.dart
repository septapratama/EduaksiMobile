import 'package:eduapp/pages/edukasi_psikologi.dart';
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
    const Color.fromRGBO(7, 210, 139, 1),
    const Color.fromARGB(255, 90, 49, 236),
    const Color.fromARGB(255, 5, 131, 227),
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
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
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
                const Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Text(
                    "Hei, Erdiii",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Poppins_Bold',
                      letterSpacing: 1,
                      wordSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Cari Artikel disini.......",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                      prefixIcon: const Icon(Icons.search, size: 25),
                    ),
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
                                      PskikologiPages()), // Replace AksiPage() with your actual page widget
                            );
                            break;
                          case 2:
                            // Navigate to KonsultasiPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EdukasiMenu()), // Replace KonsultasiPage() with your actual page widget
                            );
                            break;
                          default:
                            break;
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: menuColors[index],
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: menuIcons[index]),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            menu[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins_Regular',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Artikel",
                      style:
                          TextStyle(fontSize: 23, fontFamily: 'Poppins_Bold'),
                    ),
                    Text(
                      "Lihat Semua",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins_Bold',
                        color: customColor.primaryColors,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Article List
                Column(
                  children: articles.map((article) {
                    return Card(
                      color: customColor.cardcustom,
                      child: ListTile(
                        leading: Image.asset(
                          article['image'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          article['title'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins_Bold',
                              fontSize: 17),
                        ),
                        subtitle: Text(article['date'],
                            style: const TextStyle(
                                fontFamily: 'Poppins_SemiBold', fontSize: 12)),
                        onTap: () {
                          // Implementasi penanganan ketika item diklik (navigasi ke halaman detail, misalnya)
                        },
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
