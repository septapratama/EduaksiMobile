import 'package:eduapp/component/custom_alert.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/component/custom_loading.dart';
import 'package:eduapp/component/custom_text.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/pages/pages_auth.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_pagemove.dart';
class Lupakatasandi extends StatefulWidget {
  const Lupakatasandi({super.key});

  @override
  State<Lupakatasandi> createState() => _LupakatasandiState();
}

class _LupakatasandiState extends State<Lupakatasandi> {
  final ApiService apiService = ApiService();
  TextEditingController emailController = TextEditingController();
  void _lupaKataSandi(BuildContext context) async {
    String email = emailController.text;
    // Validasi form, misalnya memastikan semua field terisi dengan benar
    if (email.isEmpty) {
      CostumAlert.show(context, 'Email tidak boleh kosong !', "Gagal kirim otp!", Icons.error, Colors.red);
      return;
    }
    try {
      CustomLoading.showLoading(context);
      Map<String, dynamic> response = await apiService.sendOtp(email, '/verify/create/password');
      CustomLoading.closeLoading(context);
      if (response['status'] == 'success') {
        Navigator.pushReplacement(context, pageMove.movepage(OTPScreen(otpData: {'email':email, 'waktu': DateTime.parse(response['data']['waktu']), 'cond':'password'})));
      } else {
        CostumAlert.show(context, response['message'], "Gagal kirim otp!", Icons.error, Colors.red);
      }
    } catch (e) {
      print('Error saat lupa kata sandi: $e');
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
                Text(
                  'Lupa Kata Sandi',
                  textAlign: TextAlign.center,
                  style: customText.Poppins_SemiBold(
                    22,
                    customColor.primaryColors,
                    FontWeight.bold,
                  ),
                ),
                Text(
                  'Masukkan email anda!',
                  textAlign: TextAlign.center,
                  style: customText.Poppins_SemiBold(
                    16,
                    Colors.black45,
                    FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Masukan Email Anda!',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(30, 84, 135, 1),
                      fontSize: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(30, 84, 135, 1),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 21, 76, 206),
                        width: 2.0,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6.0),
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
                            0.7, // Adjust the width as needed
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                'Sudah punya akun ?',
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
                              onPressed: () => Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen())),
                              child: Text(
                                'Masuk disini',
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
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your onPressed logic here
                      _lupaKataSandi(context);
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
                            'Kirim Lupa Password',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}