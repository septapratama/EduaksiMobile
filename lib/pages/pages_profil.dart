import 'package:eduapp/component/custom_appbar_withoutarrowback.dart';
import 'package:eduapp/component/custom_textformfield.dart';
import 'package:eduapp/controller/controller_profil.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ProfilPages extends StatefulWidget {
  const ProfilPages({super.key});

  @override
  _ProfilPagesState createState() => _ProfilPagesState();
}

class _ProfilPagesState extends State<ProfilPages> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const appbarwithoutarrow(
        title: 'Profil Pengguna',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20, // Jarak antara AppBar dan Container foto profil
          ),
          GestureDetector(
            onTap: () {
              // Memanggil metode untuk memilih foto
              ImagePickerHelper().getImageFromGallery().then((File? image) {
                setState(() {
                  // Menyimpan foto yang dipilih ke dalam variabel _imageFile
                  _imageFile = image;
                });
              });
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
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          child: Icon(
                            Icons.camera_alt, // Icon kamera
                            color: Color.fromARGB(
                                255, 11, 137, 221), // Warna ikon kamera
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          CustomTextFieldWidget(
              labelText: 'Nama Pengguna',
              controller: TextEditingController(),
              initialValue: 'Nama Pengguna',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.person),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
              labelText: 'Email',
              controller: TextEditingController(),
              initialValue: 'Email',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.mail),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
              labelText: 'No Telepon',
              controller: TextEditingController(),
              initialValue: 'No Telepon',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.phone),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
            labelText: 'Kata Sandi',
            controller: TextEditingController(),
            initialValue: 'Kata Sandi',
            keyboardType: TextInputType.text,
            prefixIcon: Icons.fingerprint,
            obscureText: true, // Mengatur agar input teks tersembunyi
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(
                right: 40.0), // Sesuaikan padding dengan kebutuhan Anda
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Add your onPressed logic here
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
                  padding: EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 30.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Simpan',
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
    );
  }
}
