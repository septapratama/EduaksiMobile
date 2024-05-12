import 'dart:io';
import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_textformfieldKonsultasi.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_appbar_withoutarrowback.dart';
import 'package:eduapp/component/custom_textformfieldKonsultasi.dart';

class Konsultasipages extends StatefulWidget {
  const Konsultasipages({super.key});

  @override
  _KonsultasipagesState createState() => _KonsultasipagesState();
}

class _KonsultasipagesState extends State<Konsultasipages> {
  TextEditingController emailController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController noTelponController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? _imageFile;

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
            GestureDetector(
              onTap: () {
                // Memanggil metode untuk memilih foto
              },
              child: Center(
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
                          _imageFile != null
                              ? ClipOval(
                                  child: Image.file(
                                    _imageFile!, // Menampilkan foto yang dipilih
                                    width: 138, // Lebar foto yang dipilih
                                    height: 141, // Tinggi foto yang dipilih
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(), // Kosongkan kontainer jika tidak ada foto yang dipilih
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustomTextFieldWidget(
              labelText: 'Nama Lengkap',
              controller: namaController,
              keyboardType: TextInputType.text,
              hintText: 'Nama Pengguna',
            ),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
                labelText: 'Email',
                controller: emailController,
                hintText: 'Email'),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
                labelText: 'No Telepon',
                controller: noTelponController,
                keyboardType: TextInputType.text,
                hintText: 'No Telepon'),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
                labelText: 'Alamat Praktek',
                controller: noTelponController,
                keyboardType: TextInputType.text,
                hintText: 'Alamat Praktek'),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
              labelText: 'Deskripsi',
              controller: passwordController,
              keyboardType: TextInputType.text,
              hintText: 'Deskripsi',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              // Mengatur agar input teks tersembunyi
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(
                  left: 40.0), // Sesuaikan padding dengan kebutuhan Anda
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {
                    // _updateProfile(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Atur border radius sesuai kebutuhan Anda
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
