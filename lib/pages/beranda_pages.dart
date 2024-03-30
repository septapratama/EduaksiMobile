import 'package:eduapp/component/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Beranda extends StatelessWidget {
  Beranda({super.key});

  List menu = [
    "Edukasi",
    "Aksi",
    "Konsultasi",
    "Pengaturan",
    "GTW",
    "YWD",
  ];
  List<Color> menuColors = [
    Color.fromARGB(255, 245, 241, 0),
    const Color.fromARGB(255, 245, 2, 2),
    const Color.fromARGB(255, 230, 49, 49),
    Color.fromARGB(255, 25, 71, 196),
    Color.fromARGB(255, 7, 221, 96),
    Color.fromARGB(255, 199, 4, 140),
  ];

  List<Icon> menuIcons = [
    Icon(Icons.school, color: Colors.white, size: 30),
    Icon(Icons.business_sharp, color: Colors.white, size: 30),
    Icon(Icons.comment, color: Colors.white, size: 30),
    Icon(Icons.settings, color: Colors.white, size: 30),
    Icon(Icons.ramen_dining, color: Colors.white, size: 30),
    Icon(Icons.child_care, color: Colors.white, size: 30),
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
    // Add more articles as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: customColor.primaryColors,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                SizedBox(height: 20),
                Padding(
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
                  margin: EdgeInsets.only(top: 5, bottom: 20),
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
                      prefixIcon: Icon(Icons.search, size: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                GridView.builder(
                  itemCount: menu.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
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
                        SizedBox(height: 10),
                        Text(
                          menu[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins_Regular',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
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
                SizedBox(height: 10),
                // Article List
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Image.asset(
                          articles[index]['image'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          articles[index]['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins_Bold',
                              fontSize: 17),
                        ),
                        subtitle: Text(articles[index]['date'],
                            style: TextStyle(
                                fontFamily: 'Poppins_SemiBold', fontSize: 12)),
                        onTap: () {
                          // Implementasi penanganan ketika item diklik (navigasi ke halaman detail, misalnya)
                        },
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
