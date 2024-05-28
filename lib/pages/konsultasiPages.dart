import 'dart:convert';
import 'dart:io';
import 'package:eduapp/component/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eduapp/component/custom_textformfieldKonsultasi.dart';
import 'package:eduapp/pages/konsultasi.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/component/custom_appbar_withoutarrowback.dart';

class Konsultasipages extends StatefulWidget {
  final String idKonsultasi;
  const Konsultasipages({super.key, required this.idKonsultasi});

  @override
  _KonsultasipagesState createState() => _KonsultasipagesState();
}

class _KonsultasipagesState extends State<Konsultasipages> {
  final ApiService apiService = ApiService();
  late Map<String, dynamic> konsultasiData;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _noTelponController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  late String _linkFoto = '';
  final String docstorNotFound = 'assets/images/default_profile.jpg';

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    try {
      Map<String, dynamic> response = await apiService.getKonsultasiDetail(widget.idKonsultasi);
      if (response['status'] == 'success') {
        setState(() {
          konsultasiData = response['data'];
          _namaController.text = konsultasiData['nama_lengkap'];
          _kategoriController.text = 'Dokter ${konsultasiData['kategori']}';
          _noTelponController.text = konsultasiData['no_telpon'];
          _alamatController.text = konsultasiData['alamat'];
          _emailController.text = konsultasiData['email'];
          _linkFoto = konsultasiData['foto'];
        });
      } else if(response['code'] == 404){
        Navigator.pushReplacement(context, pageMove.movepage(Konsultasi()));
      }else{
        String errRes = response['message'].toString();
        if(errRes.contains('login') || errRes.contains('expired')){
          Future.delayed(const Duration(seconds: 2), () {
            return Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen()));
          });
        }
      }
    } catch (e) {
      print('Error fetching konsultasi detail page: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Biodata Ahli',
        buttonOnPressed: () {
          // Navigator.push(
          //   context,
          //   // MaterialPageRoute(builder: (context) => AksiMenu()),
          // );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20, // Jarak antara AppBar dan Container foto profil
            ),
            Center(
              // Menengahkan konten secara horizontal dan vertikal
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 138.0, // Lebar foto profil
                    height: 141.0, // Tinggi foto profil
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle, // Bentuk lingkaran
                      color: Colors.blue, // Warna latar belakang
                    ),
                  ),
                  Container(
                    width: 138.0, // Lebar foto profil
                    height: 141.0, // Tinggi foto profil
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle, // Bentuk lingkaran
                      color: Colors.transparent, // Hapus warna latar belakang
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: _linkFoto.startsWith('assets/') // Check if _linkFoto is an asset
                          ? Image.asset(
                              _linkFoto,
                              width: 138,
                              height: 141,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                            '${apiService.imgUrl}/konsultasi/$_linkFoto',
                            width: 138,
                            height: 141,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print('Error loading image:${error}');
                              return Image.asset(
                                docstorNotFound,
                                width: 138,
                                height: 141,
                                fit: BoxFit.cover,
                                // fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            CustomTextFieldWidget(
              labelText: 'Nama Lengkap',
              controller: _namaController,
              keyboardType: TextInputType.text,
              hintText: 'Nama Pengguna',
            ),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
                labelText: 'Email',
                controller: _emailController,
                hintText: 'Email'),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
                labelText: 'No Telepon',
                controller: _noTelponController,
                keyboardType: TextInputType.text,
                hintText: 'No Telepon'),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
                labelText: 'Alamat Praktek',
                controller: _alamatController,
                keyboardType: TextInputType.text,
                hintText: 'Alamat Praktek'),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
              labelText: 'Deskripsi',
              controller: _kategoriController,
              keyboardType: TextInputType.text,
              hintText: 'Deskripsi',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              // Mengatur agar input teks tersembunyi
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20), // Sesuaikan padding dengan kebutuhan Anda
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, pageMove.movepage(Konsultasi()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Kembali',
                              style: TextStyle(
                                fontFamily: 'Poppins_SemiBold',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String phoneNumber = _noTelponController.text.replaceFirst('0', '62');
                        String whatsappUrl = 'https://wa.me/$phoneNumber';
                        if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                          await launchUrl(Uri.parse(whatsappUrl));
                        } else {
                          print('Could not launch $whatsappUrl');
                          // throw 'Could not launch $whatsappUrl';
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12.0), // Atur border radius sesuai kebutuhan Anda
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 13.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/wa.png',
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'WhatsApp',
                              style: TextStyle(
                                fontFamily: 'Poppins_SemiBold',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
