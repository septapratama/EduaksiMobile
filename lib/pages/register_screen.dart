// register_screen.dart
import 'package:eduapp/component/custom_alert.dart';
import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_loading.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/pages/pages_auth.dart';
import 'package:eduapp/pages/pages_lupakatasandi.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/controller/controller_register.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/utils/ApiService.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  // final Map<String, dynamic> otpData;
  // RegisterScreen({super.key, required this.otpData});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;
  bool _isPasswordVisible1 = false;
  String _passwordStrength = '';
  final RegisterController _controller = RegisterController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Add this line
  final ApiService apiService = ApiService();
  TextEditingController emailController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inisialisasi nilai _passwordStrength ke 'Rendah' saat form pertama kali dibuka
    _passwordStrength = 'Rendah';
  }
  void _register() async {
    String email = emailController.text;
    String namaLengkap = namaController.text;
    String kataSandi = passwordController.text;
    String konfirmasi = confirmPasswordController.text;

    // Validasi form, misalnya memastikan semua field terisi dengan benar
    if(email.isEmpty){
      CostumAlert.show(context, "Email tidak boleh kosong !", "gagal mendaftar!",Icons.error, Colors.red);
      return;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      CostumAlert.show(context, "Email tidak valid!", "Gagal mendaftar!", Icons.error, Colors.red);
      return;
    }
    if(namaLengkap.isEmpty){
      CostumAlert.show(context, "Nama Lengkap tidak boleh kosong !", "gagal mendaftar!",Icons.error, Colors.red);
      return;
    }
    if(kataSandi.isEmpty){
      CostumAlert.show(context, "Kata sandi tidak boleh kosong !", "gagal mendaftar!",Icons.error, Colors.red);
      return;
    }
    if (kataSandi.length < 8) {
      CostumAlert.show(context, "Kata sandi harus terdiri dari minimal 8 karakter !", "Gagal mendaftar!", Icons.error, Colors.red);
      return;
    }
    if (!RegExp(r'\d').hasMatch(kataSandi)) {
      CostumAlert.show(context, "Kata sandi harus mengandung minimal 1 angka!", "Gagal mendaftar!", Icons.error, Colors.red);
      return;
    }
    if(konfirmasi.isEmpty){
      CostumAlert.show(context, "Ulangi kata sandi tidak boleh kosong !", "gagal mendaftar!",Icons.error, Colors.red);
      return;
    }
    if (kataSandi != konfirmasi) {
      CostumAlert.show(context, "Kata sandi dan Ulangi kata sandi tidak sesuai !", "gagal mendaftar!", Icons.error,Colors.red);
      return;
    }
    try {
      CustomLoading.showLoading(context);
      Map<String, dynamic> response = await apiService.register(email, namaLengkap, kataSandi, konfirmasi);
      CustomLoading.closeLoading(context);
      if (response['status'] == 'success') {
        Navigator.pushReplacement(context, pageMove.movepage(OTPScreen(otpData: {'email':email, 'waktu': DateTime.parse(response['data']['waktu']), 'cond':'email'})));
      } else {
        CostumAlert.show(context, "${response['message']}", "gagal mendaftar!", Icons.error,Colors.red);
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20.0),
                  Center(
                    child: Image.asset(
                      'assets/images/education_login.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 0.0),
                  const Text(
                    'Tambah Akun',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins_SemiBold',
                      fontWeight: FontWeight.w800,
                      color: Color.fromRGBO(30, 84, 135, 1),
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 60.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: 'Poppins_SemiBold',
                          color: Color.fromRGBO(30, 84, 135, 1),
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(30, 84, 135, 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(30, 84, 135, 1),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 21, 76, 206),
                              width: 2.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nama Lengkap',
                        style: TextStyle(
                          fontFamily: 'Poppins_SemiBold',
                          color: Color.fromRGBO(30, 84, 135, 1),
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextField(
                        controller: namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(30, 84, 135, 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(30, 84, 135, 1),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 21, 76, 206),
                              width: 2.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kata Sandi',
                        style: TextStyle(
                          fontFamily: 'Poppins_SemiBold',
                          color: Color.fromRGBO(30, 84, 135, 1),
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextField(
                        controller: passwordController,
                        onChanged: (password) {
                          setState(() {
                            _passwordStrength =
                                _controller.evaluatePasswordStrength(password);
                          });
                        },
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Kata Sandi',
                          labelStyle: const TextStyle(
                            color: Color.fromRGBO(30, 84, 135, 1),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(30, 84, 135, 1),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 21, 76, 206),
                              width: 2.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            right:
                                8.0), // Sesuaikan jarak kanan sesuai kebutuhan
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, // Meletakkan widget di sebelah kanan
                          children: [
                            Text(
                              _passwordStrength,
                              style: TextStyle(
                                color: (_passwordStrength == 'Kuat')
                                    ? Colors.green
                                    : (_passwordStrength == 'Sedang')
                                        ? Colors.orange
                                        : Colors.red,
                              ),
                            ),
                            const SizedBox(width: 8), // Spasi antara teks dan animasi
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 5.0,
                              width: (_passwordStrength == 'Kuat')
                                  ? 100.0
                                  : // Sesuaikan lebar animasi sesuai kekuatan kata sandi
                                  (_passwordStrength == 'Sedang')
                                      ? 50.0
                                      : 25.0,
                              color: (_passwordStrength == 'Kuat')
                                  ? Colors.green
                                  : (_passwordStrength == 'Sedang')
                                      ? Colors.orange
                                      : Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ulangi Kata Sandi',
                        style: TextStyle(
                          fontFamily: 'Poppins_SemiBold',
                          color: Color.fromRGBO(30, 84, 135, 1),
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: !_isPasswordVisible1,
                        decoration: InputDecoration(
                          labelText: 'Ulangi Kata Sandi',
                          labelStyle: const TextStyle(
                            color: Color.fromRGBO(30, 84, 135, 1),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(30, 84, 135, 1),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 21, 76, 206),
                              width: 2.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              icon: Icon(
                                _isPasswordVisible1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible1 = !_isPasswordVisible1;
                                });
                              },
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _register();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Daftar',
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
                  const SizedBox(height: 10.0),
                  Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double fontSize = 15.0;
                        double screenWidth = MediaQuery.of(context).size.width;
                        if (screenWidth < 400) {
                          fontSize = 12.0;
                        } else if (screenWidth < 600) {
                          fontSize = 13.0;
                        } else {
                          fontSize = 16.0;
                        }
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'Apakah anda sudah memiliki akun?',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins_SemiBold',
                                    color: const Color.fromRGBO(0, 0, 0, 0.445),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Add logic to navigate to the registration page
                                  Navigator.pushReplacement(context,
                                      pageMove.movepage(const LoginScreen()));
                                },
                                child: Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins_SemiBold',
                                    color: const Color.fromRGBO(30, 84, 135, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}