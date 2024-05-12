import 'package:eduapp/controller/controller_register.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:eduapp/utils/Google_login.dart';
import 'package:eduapp/utils/navigationbar.dart';
import 'package:eduapp/utils/user_model_baru.dart';
import 'package:eduapp/utils/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_button.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/component/custom_text.dart';
import 'package:eduapp/pages/pages_lupakatasandi.dart';
import 'package:eduapp/pages/register_screen.dart';
import 'package:eduapp/utils/navigationbar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();
  final GoogleLogin googlelogin = GoogleLogin();

  void alert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context, message),
        );
      },
    );
  }

  void _login(BuildContext context) async {
    String email = emailController.text;
    String kataSandi = passwordController.text;
    // Validasi form, misalnya memastikan semua field terisi dengan benar
    if (email.isEmpty) {
      alert(context, "Email tidak boleh kosong !");
      return;
    }
    if (kataSandi.isEmpty) {
      alert(context, "Kata sandi tidak boleh kosong !");
      return;
    }
    try {
      Map<String, dynamic> response = await apiService.login(email, kataSandi);
      if (response['status'] == 'success') {
        Navigator.pushReplacement(context, pageMove.movepage(const BottomNav()));
      } else {
        alert(context, response['message']);
      }
    } catch (e) {
      print('Error saat login: $e');
    }
  }

  void _loginGoogle(BuildContext context) async {
    try {
      final response = await googlelogin.loginGoogle();
      if (response['status'] == 'success') {
        return;
        Navigator.pushReplacement(context, pageMove.movepage(const BottomNav()));
      } else {
        // print('Login failed: ${response['message']}');
        alert(context, "terjadi kesalahan pada jaringan");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20.0),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context, pageMove.movepage(const BottomNav()));
                    },
                    child: Image.asset(
                      'assets/images/education_login.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(height: 0.0),
                const Text(
                  'Selamat Datang',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins_SemiBold',
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(30, 84, 135, 1),
                    fontSize: 20.0,
                  ),
                ),
                const Text(
                  'EduAksi Parenting',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins_SemiBold',
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(30, 84, 135, 1),
                    fontSize: 18.0,
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
                            fontWeight: FontWeight.w400),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(30, 84, 135, 1),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 21, 76, 206),
                            width: 2.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      style: const TextStyle(
                        color: Color.fromRGBO(30, 84, 135, 1),
                        fontSize: 16.0, // Change the font size here
                        fontFamily:
                            'Poppins_SemiBold', // Change the font type here
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
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Kata Sandi',
                        labelStyle: const TextStyle(
                            color: Color.fromRGBO(30, 84, 135, 1),
                            fontWeight: FontWeight.w400
                            // Default text color
                            ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(8.0)), // Set border radius here
                          borderSide: BorderSide(
                            color: Color.fromRGBO(30, 84, 135,
                                1), // Border color for the enabled state
                            width: 2.0, // Border width for the enabled state
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(8.0)), // Set border radius here
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 21, 76,
                                206), // Border color for the focused state
                            width: 2.0, // Border width for the focused state
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0), // Adjust the right padding as needed
                          child: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors
                                  .black, // Adjust the color of the visibility icon
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
                        color: Color.fromRGBO(30, 84, 135, 1),
                        fontSize: 16.0, // Change the font size here
                        fontFamily:
                            'Poppins_SemiBold', // Change the font type here
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Tambahkan logika untuk proses lupa kata sandi
                      Navigator.pushReplacement(
                          context, pageMove.movepage(const Lupakatasandi()));
                    },
                    child: const Text(
                      'Lupa Kata Sandi?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(30, 84, 135, 1),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0), // Adjust horizontal padding as needed
                  child: ElevatedButton(
                    onPressed: () {
                      _login(context);
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
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0), // Adjust vertical padding as needed
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Masuk',
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
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        _loginGoogle(context);
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            width: 54,
                            height: 54,
                          ),
                          const SizedBox(width: 2),
                          const Flexible(
                            child: Text(
                              'Masuk dengan Google',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins_SemiBold',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black,
                              ),
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
                      double fontSize = 15.0; // Initial font size
                      double screenWidth = MediaQuery.of(context).size.width;

                      // Adjust the font size based on the width of the screen
                      if (screenWidth < 400) {
                        fontSize = 12.0;
                      } else if (screenWidth < 600) {
                        fontSize = 13.0;
                      } else {
                        fontSize = 16.0;
                      }

                      return SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.8, // Adjust the width as needed
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                'Belum punya akun?',
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
                              onPressed: () => Navigator.pushReplacement(context, pageMove.movepage(const RegisterScreen())),
                              child: Text(
                                'Daftar Disini',
                                style: TextStyle(
                                  fontSize:
                                      fontSize, // Use the fontSize variable here
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
    );
  }
}

Widget contentBox(BuildContext context, String message) {
  return Stack(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.only(
          left: 20,
          top: 45,
          right: 20,
          bottom: 20,
        ),
        margin: const EdgeInsets.only(top: 45),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
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
            const Text(
              'Gagal Login!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'OKE',
                  style: TextStyle(color: Color.fromRGBO(203, 164, 102, 1)),
                ),
              ),
            ),
          ],
        ),
      ),
      const Positioned(
        top: 0,
        left: 20,
        right: 20,
        child: CircleAvatar(
          backgroundColor: Colors.redAccent,
          radius: 30,
          child: Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    ],
  );
}
