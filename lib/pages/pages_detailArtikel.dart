import 'dart:convert';

import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/pages/edukasi_diisiArtikel.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/material.dart';

class DetailArtikel extends StatefulWidget {
  final Map<String, dynamic> detailData;
  DetailArtikel({super.key, required this.detailData});
  final Map<String, dynamic> tableConst = {'disi':'digital_literasi', 'emotal':'emosi_mental'};

  @override
  _DetailArtikelState createState() => _DetailArtikelState();
}
class _DetailArtikelState extends State<DetailArtikel> {
  final ApiService apiService = ApiService();
  final String artikelNotFound = 'assets/images/artikel 1.png';
  late Map<String, dynamic> artikelData = {};
  late List<Map<String, String>> articles = [];
  bool isDone = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      Map<String, dynamic> response = {};
      switch (widget.detailData['table']) {
        case 'disi':
          response = await apiService.getDisiDetail(widget.detailData['id_data']);
          break;
        case 'emotal':
          response = await apiService.getEmotalDetail(widget.detailData['id_data']);
          break;
        case 'nutrisi':
          response = await apiService.getNutrisiDetail(widget.detailData['id_data']);
          break;
        case 'pengasuhan':
          response = await apiService.getPengasuhanDetail(widget.detailData['id_data']);
          break;
        case 'artikel':
          response = await apiService.getArtikelDetail(widget.detailData['id_data']);
          break;
      }
      if (response['status'] == 'success') {
        setState(() {
          articles = (response['data']['artikel'] as List).map((item) => Map<String, String>.from(item)).toList();
          artikelData = response['data']['detail'];
          isDone = true;
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
      print('Error fetching detail artikel page : $e');
    }
  }

  List<Widget> _buildDescriptionWidgets(String description) {
    List<Widget> widgets = [];
    List<String> lines = description.split('\n');

    for (String line in lines) {
      widgets.add(
        const SizedBox(height: 5),
      );
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            line,
            textAlign: TextAlign.left,
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    if(isDone){
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: CustomAppBar(
                title: artikelData['judul'],
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
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        '${apiService.imgUrl}/${widget.tableConst[widget.detailData['table']] ?? widget.detailData['table']}/${artikelData['gambar']}',
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image:$error');
                          return Image.asset(
                            width: MediaQuery.of(context).size.width * 0.8,
                            'assets/images/Kesenian.jpg',
                            height: 150,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      artikelData['judul'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      artikelData['tanggal'],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ..._buildDescriptionWidgets(artikelData['deskripsi']),
                ]),
              )
            ),

            // Bagian implementasi list artikel
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
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
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailArtikel(detailData: {'id_data':articles[index]['id_data'], 'table': widget.detailData['table']})));
                          },
                          child:  Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Card(
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    '${apiService.imgUrl}/${widget.tableConst[widget.detailData['table']] ?? widget.detailData['table']}/${articles[index]['gambar']}',
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      print('Error loading image:$error');
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
    }else{
      return Scaffold(
        appBar: AppBar(
          title: const Text('Loading...'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
  }
}
