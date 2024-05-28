import 'dart:convert';
import 'dart:io';
import 'package:eduapp/component/custom_alert.dart';
import 'package:eduapp/component/custom_loading.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:eduapp/component/custom_appbar_withoutarrowback.dart';
import 'package:eduapp/component/custom_textformfield.dart';
import 'package:eduapp/controller/controller_profil.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/utils/JwtProvider.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/utils/ApiService.dart';

class ProfilPages extends StatefulWidget {
  const ProfilPages({super.key});

  @override
  _ProfilPagesState createState() => _ProfilPagesState();
}

class _ProfilPagesState extends State<ProfilPages> {
  final JwtProvider jwtProvider = JwtProvider();
  final ApiService apiService = ApiService();
  TextEditingController emailController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController noTelponController = TextEditingController();
  TextEditingController passwordLamaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordUlangiController = TextEditingController();
  String? jenisKelamin = 'laki-laki';
  File? _imageFile;
  late final String dirPath;
  late String _filePath = 'assets/images/default_profile.jpg';
  @override
  void initState() {
    super.initState();
    fetchData();
    setupProfilePhoto();
  }
  Future<void> fetchData() async {
    Map<String, dynamic> profileData = await jwtProvider.getData();
    setState(() {
      emailController.text = profileData['email'];
      namaController.text = profileData['nama_lengkap'];
      jenisKelamin = profileData['jenis_kelamin'];
      noTelponController.text = profileData['no_telpon'];
    });
  }
  Future<void> setupProfilePhoto() async {
    try{
      dirPath = '${(await getApplicationDocumentsDirectory()).path}/user/profile';
      if(!(await Directory(dirPath).exists())){
        await Directory(dirPath).create(recursive: true);
      }else{
        List<FileSystemEntity> files = Directory(dirPath).listSync();
        if(files.isNotEmpty){
          FileSystemEntity? file = files.firstWhere(
            (entity) => entity is File,
          );
          if (file != null && file is File) {
            _filePath = file.path;
            setState(() {});
            return;
          }
        }
      }
      Map<String, dynamic> res = await apiService.getFotoProfile();
      if(res['status'] == 'error'){
        String errRes = res['message'].toString();
        if(errRes.contains('login') || errRes.contains('expired')){
          Future.delayed(const Duration(seconds: 2), () {
            return Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen()));
          });
        } else if (res['status'] == 404 || errRes.contains('not found')) {
          _filePath = 'assets/images/default_profile.jpg'; // Use default profile image
          if(mounted){
            setState(() {});
          }
      }
      }else{
        _filePath = res['data'];
        setState(() {});
      }
    }catch(e){
      print('error set profile $e');
    }
  }
  void _updateProfile(BuildContext context) async {
    String email = emailController.text;
    String nama_lengkap = namaController.text;
    String no_telpon = noTelponController.text;
    String kata_sandiLama = passwordLamaController.text;
    String kata_sandi = passwordController.text;
    String kata_sandiUlangi = passwordUlangiController.text;
    bool isUpPass = false;
    // Validasi form, misalnya memastikan semua field terisi dengan benar
    if(email.isEmpty || email == null){
      CostumAlert.show(context, "Email tidak boleh kosong !", "gagal update profile!",Icons.error, Colors.red);
      return;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      CostumAlert.show(context, "Email tidak valid!", "Gagal update profile!", Icons.error, Colors.red);
      return;
    }
    if(nama_lengkap.isEmpty){
      CostumAlert.show(context, "Nama Lengkap tidak boleh kosong !", "gagal update profile!",Icons.error, Colors.red);
      return;
    }
    if(jenisKelamin?.isEmpty ?? true){
      CostumAlert.show(context, "Jenis kelamin tidak boleh kosong !", "gagal update profile!",Icons.error, Colors.red);
      return;
    }
    if(no_telpon.isEmpty){
      CostumAlert.show(context, "No telpon tidak boleh kosong !", "gagal update profile!",Icons.error, Colors.red);
      return;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(no_telpon)) {
      CostumAlert.show(context, "No telpon hanya boleh berisi angka !", "gagal update profile!", Icons.error, Colors.red);
      return;
    }
    if (no_telpon.length < 10 || no_telpon.length > 13) {
      CostumAlert.show(context, "No telpon harus memiliki panjang antara 10 dan 13 digit!", "Gagal update profile!", Icons.error, Colors.red);
      return;
    }
    if (!no_telpon.startsWith("08")) {
      CostumAlert.show(context, "No telpon harus dimulai dengan '08'!", "Gagal update profile!", Icons.error, Colors.red);
      return;
    }
    if((kata_sandiLama.isNotEmpty && kata_sandiLama != null) || (kata_sandi.isNotEmpty && kata_sandi != null) || kata_sandiUlangi.isNotEmpty && kata_sandiUlangi != null){
      if(kata_sandiLama.isEmpty || kata_sandiLama == null){
        CostumAlert.show(context, "Kata Sandi lama tidak boleh kosong !", "gagal update profile!",Icons.error, Colors.red);
        return;
      }
      if(kata_sandi.isEmpty || kata_sandi == null){
        CostumAlert.show(context, "Kata Sandi baru tidak boleh kosong !", "gagal update profile!",Icons.error, Colors.red);
        return;
      }
      if(kata_sandiUlangi.isEmpty || kata_sandiUlangi == null){
        CostumAlert.show(context, "Konfirmasi Kata Sandi tidak boleh kosong !", "gagal update profile!",Icons.error, Colors.red);
        return;
      }
      isUpPass = true;
    }
    try {
      CustomLoading.showLoading(context);
      Map<String, dynamic> response;
      if(_imageFile != null){
        if(isUpPass){
          response = await apiService.updateProfile(email, nama_lengkap, jenisKelamin!, no_telpon, kata_sandiLama, kata_sandi, kata_sandiUlangi, _imageFile);
        }else{
          response = await apiService.updateProfile(email, nama_lengkap, jenisKelamin!, no_telpon, null, null , null, _imageFile);
        }
      }else{
        if(isUpPass){
          response = await apiService.updateProfile(email, nama_lengkap, jenisKelamin!, no_telpon, kata_sandiLama, kata_sandi, kata_sandiUlangi, null);
        }else{
          response = await apiService.updateProfile(email, nama_lengkap, jenisKelamin!, no_telpon, null, null, null, null);
        }
      }
      CustomLoading.closeLoading(context);
      if (response['status'] == 'success') {
        if(_imageFile != null){
          // save img
          String filePath = '$dirPath/foto${p.extension(_imageFile!.path)}';
          await _imageFile!.copy(filePath);
          List<FileSystemEntity> files = Directory(dirPath).listSync();
        }
        CostumAlert.show(context, "Profile Berhasil diperbarui","Berhasil Perbarui!",Icons.check, Colors.green);
      } else {
        CostumAlert.show(context, response['message'], "Gagal Perbarui!", Icons.error, Colors.red);
        String errRes = response['message'].toString();
        if(errRes.contains('login') || errRes.contains('expired')){
          Future.delayed(const Duration(seconds: 2), () {
            return Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen()));
          });
        }
      }
    } catch (e) {
      print('Error saat update profile page : $e');
    }
  }
  void _logout(BuildContext context) async {
    try{
      CustomLoading.showLoading(context);
      Map<String, dynamic> response = await apiService.logout();
      CustomLoading.closeLoading(context);
        if (response['status'] == 'success') {
          CostumAlert.show(context, response['message'],"Berhasil Logout!",Icons.check, Colors.green);
          //delete profile foto
          List<FileSystemEntity> files = Directory(dirPath).listSync();
          for (FileSystemEntity file in files) {
            try {
              if (file is File) {
                await file.delete();
              } else if (file is Directory) {
                await file.delete(recursive: true);
              }
            } catch (e) {
              print('Error deleting file: ${file.path}, error: $e');
            }
          }
          Future.delayed(const Duration(seconds: 2), () {
            return Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen()));
          });
        } else {
          CostumAlert.show(context, response['message'], "Gagal Logout!", Icons.error, Colors.red);
          String errRes = response['message'].toString();
          if(errRes.contains('login') || errRes.contains('expired')){
            Future.delayed(const Duration(seconds: 2), () {
              return Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen()));
            });
          }
        }
    } catch (e) {
      print('Error saat logoutt page : $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const appbarwithoutarrow(
        title: 'Profil Pengguna',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20, // Jarak antara AppBar dan Container foto profil
            ),
          GestureDetector(
            onTap: () async {
              // Memanggil metode untuk memilih foto
              final image = await ImagePickerHelper().getImageFromGallery();
              if (!mounted) return;
              if (image != null) {
                if(image.lengthSync() >= (5 * 1024 * 1024)){
                  CostumAlert.show(context, 'Foto tidak boleh lebih dari 5 MB', "Gagal pilih foto!", Icons.error, Colors.red);
                  return;
                }
                if (!['.jpg', '.jpeg', '.png'].contains(p.extension(image.path))) {
                  CostumAlert.show(context, 'Foto harus jpg, jpeg, png', "Gagal pilih foto!", Icons.error, Colors.red);
                  return;
                }
                setState(() {
                  // Menyimpan foto yang dipilih ke dalam variabel _imageFile
                  _imageFile = image;
                });
              };
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
                            : _filePath != null // Check if _filePath is not null
                            ? ClipOval(
                                child: _filePath.startsWith('assets/') // Check if _filePath is an asset
                                    ? Image.asset(
                                        _filePath,
                                        width: 138,
                                        height: 141,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(_filePath), // Display the saved photo
                                        width: 138,
                                        height: 141,
                                        fit: BoxFit.cover,
                                      ),
                              )
                            : Container(),  // Kosongkan kontainer jika tidak ada foto yang dipilih
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
            horizontal: 20,
            prefixIcon: Icons.person
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Jenis Kelamin',
              prefixIcon: const Icon(Icons.wc),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.0),
                borderSide: const BorderSide(color: Color.fromRGBO(30, 84, 135, 1)),
              ),
            ),
            value: jenisKelamin,
            items: const [
              DropdownMenuItem(
                value: 'laki-laki',
                child: Text('Laki-Laki'),
              ),
              DropdownMenuItem(
                value: 'perempuan',
                child: Text('Perempuan'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                jenisKelamin = value;
              });
            },
          ),
          ),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
            labelText: 'Email',
            controller: emailController,
            initialValue: 'Email',
            keyboardType: TextInputType.text,
            prefixIcon: Icons.mail,
            horizontal: 20,
          ),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
            labelText: 'No Telepon',
            controller: noTelponController,
            initialValue: 'No Telepon',
            keyboardType: TextInputType.text,
            prefixIcon: Icons.phone,
            horizontal: 20,
          ),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
            labelText: 'Kata Sandi Lama',
            controller: passwordLamaController,
            keyboardType: TextInputType.text,
            prefixIcon: Icons.fingerprint,
            obscureText: true, // Mengatur agar input teks tersembunyi
            horizontal: 20,
          ),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
            labelText: 'Kata Sandi Baru',
            controller: passwordController,
            keyboardType: TextInputType.text,
            prefixIcon: Icons.fingerprint,
            obscureText: true,
            horizontal: 20,
             // Mengatur agar input teks tersembunyi
          ),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
            labelText: 'Konfirmasi Kata Sandi Baru',
            controller: passwordUlangiController,
            keyboardType: TextInputType.text,
            prefixIcon: Icons.fingerprint,
            obscureText: true, // Mengatur agar input teks tersembunyi
            horizontal: 20,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20), // Sesuaikan padding dengan kebutuhan Anda
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _logout(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/logout.png',
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Logout',
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
                  onPressed: () {
                    _updateProfile(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12.0), // Atur border radius sesuai kebutuhan Anda
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
              ],
            ),
          ),
        ],
      ),
      )
    );
  }
}