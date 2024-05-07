import 'package:eduapp/component/custom_appbar_withoutarrowback.dart';
import 'package:eduapp/component/custom_textformfield.dart';
import 'package:eduapp/controller/controller_profil.dart';
import 'package:eduapp/utils/JwtProvider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:eduapp/utils/ApiService.dart';

class ProfilPages extends StatefulWidget {
  const ProfilPages({super.key});

  @override
  _ProfilPagesState createState() => _ProfilPagesState();
}

class _ProfilPagesState extends State<ProfilPages> {
  File? _imageFile;
  JwtProvider jwtProvider = JwtProvider();
  TextEditingController emailController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController noTelponController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    Map<String, dynamic> profileData = await jwtProvider.getData();
    setState(() {
      emailController.text = profileData['email'];
      namaController.text = profileData['nama'];
      noTelponController.text = profileData['telp'];
    });
  }
  void alert(BuildContext context, String message, String title, IconData icon, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context, message, title, icon, color),
        );
      },
    );
  }
  void _updateProfile(BuildContext context) async {
    final ApiService apiService = ApiService();
    String email = emailController.text;
    String nama_lengkap = namaController.text;
    String no_telpon = noTelponController.text;
    String kata_sandi = passwordController.text;
    // Validasi form, misalnya memastikan semua field terisi dengan benar
    if(email.isEmpty || email == null){
      alert(context, "Email tidak boleh kosong !", "gagal mendaftar!",Icons.error, Colors.red);
      return;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      alert(context, "Email tidak valid!", "Gagal mendaftar!", Icons.error, Colors.red);
      return;
    }
    if(nama_lengkap.isEmpty || nama_lengkap == null){
      alert(context, "Nama Lengkap tidak boleh kosong !", "gagal mendaftar!",Icons.error, Colors.red);
      return;
    }
    if(no_telpon.isEmpty || no_telpon == null){
      alert(context, "No telpon tidak boleh kosong !", "gagal mendaftar!",Icons.error, Colors.red);
      return;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(no_telpon)) {
      alert(context, "No telpon hanya boleh berisi angka !", "gagal mendaftar!", Icons.error, Colors.red);
      return;
    }
    if (no_telpon.length < 10 || no_telpon.length > 13) {
        alert(context, "No telpon harus memiliki panjang antara 10 dan 13 digit!", "Gagal mendaftar!", Icons.error, Colors.red);
        return;
    }
    if (!no_telpon.startsWith("08")) {
        alert(context, "No telpon harus dimulai dengan '08'!", "Gagal mendaftar!", Icons.error, Colors.red);
        return;
    }
    try {
      Map<String, dynamic> response = await apiService.updateProfile(email, nama_lengkap, no_telpon, kata_sandi);
      if (response['status'] == 'success') {
        // update the user data using the provider
        // context.read()<UserProvider>().setUserBaru(
        //       UserModelBaru(
        //         email: email,
        //         nama_lengkap: response['data']['nama_lengkap'] ?? '',
        //         no_hp: response['data']['no_hp'] ?? '',
        //         foto_profil: response['data']['foto_profil'] ?? '',
        //       ),
        //     );
        alert(context, "Profile Berhasil diperbarui","Berhasil Perbarui!",Icons.check, Colors.green);
      } else {
        alert(context, response['message'], "Gagal Perbarui!", Icons.error, Colors.red);
      }
    } catch (e) {
      print('Error saat login: $e');
    }
  }
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
              controller: namaController,
              initialValue: 'Nama Pengguna',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.person),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
              labelText: 'Email',
              controller: emailController,
              initialValue: 'Email',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.mail),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
              labelText: 'No Telepon',
              controller: noTelponController,
              initialValue: 'No Telepon',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.phone),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
            labelText: 'Kata Sandi',
            controller: passwordController,
            initialValue: 'Kata Sandi Lama',
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
                  _updateProfile(context);
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
Widget contentBox(BuildContext context, String message, String title, IconData icon, Color color) {
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(
          left: 20,
          top: 45,
          right: 20,
          bottom: 20,
        ),
        margin: EdgeInsets.only(top: 45),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 10),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              message,
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 22),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OKE',
                  style: TextStyle(color: Color.fromRGBO(203, 164, 102, 1)),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 0,
        left: 20,
        right: 20,
        child: CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    ],
  );
}