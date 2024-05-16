import 'dart:convert';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/konsultasiPages.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:eduapp/utils/navigationbar.dart';
import 'package:flutter/material.dart';

class Konsultasi extends StatefulWidget {
  Konsultasi({super.key});

  @override
  _KonsultasiState createState() => _KonsultasiState();
}
class _KonsultasiState extends State<Konsultasi> {
  final ApiService apiService = ApiService();
  final String docstorNotFound = 'assets/images/default_profile.jpg';
  List<Map<String, dynamic>> dataDokter = [];
  // Data dummy untuk dokter
  // final List<Map<String, String>> dataDokter = [
  //   {
  //     'nama': 'Septia Rahma Dwi P, S.Psi',
  //     'kategori': 'Psikolog Anak',
  //     'foto': 'assets/images/logo_eyes.png'
  //   },
  //   {
  //     'nama': 'Septia Rahma Dwi P, S.Psi',
  //     'kategori': 'Psikolog Anak',
  //     'foto': 'assets/images/logo_eyes.png'
  //   },
  //    {
  //     'nama': 'Septia Rahma Dwi P, S.Psi',
  //     'kategori': 'Psikolog Anak',
  //     'foto': 'assets/images/logo_eyes.png'
  //   },
  //   // Tambahkan lebih banyak dokter di sini
  // ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    try {
      Map<String, dynamic> response = await apiService.getKonsultasi();
      if (response['status'] == 'success') {
        setState(() {
          dataDokter = List<Map<String, dynamic>>.from(response['data']);
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
      print('Error fetching konsultasi data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: CustomAppBar(
              title: 'Artikel Edukasi Psikologi',
              buttonOnPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNav()),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Temukan Ahli Spesialismu........',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var doctor = dataDokter[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Konsultasipages(idKonsultasi: doctor['id_konsultasi'])));
                  },
                  child:Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: customColor.primaryColors,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              '${apiService.imgUrl}/konsultasi/${doctor['foto']}',
                              width: 135,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image:${error}');
                                return Image.asset(
                                  docstorNotFound,
                                  width: 135,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  // fit: BoxFit.contain,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(doctor['nama']!, style: const TextStyle(fontFamily: 'Poppins_Bold', color: Colors.white)),
                              Text('Dokter ' +doctor['kategori']!, style: const TextStyle(fontFamily: 'Poppins_Bold', color: Colors.white))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: dataDokter.length,
            ),
          ),
        ],
      ),
    );
  }
}