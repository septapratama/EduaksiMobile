import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/component/custom_text.dart';
import 'package:eduapp/pages/pages_auth.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_pagemove.dart';
class Lupakatasandi extends StatefulWidget {
  const Lupakatasandi({Key? key}) : super(key: key);

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
      // alert(context, "Email tidak boleh kosong !");
      print("Email tidak boleh kosong !");
      return;
    }
    try {
      Map<String, dynamic> response = await apiService.lupaPassword(email);
      if (response['status'] == 'success') {
        Navigator.pushReplacement(context, pageMove.movepage(OTPScreen(otpData: {'email':email, 'waktu':response['data']})));
      } else {
        // alert(context, response['message']);
      }
    } catch (e) {
      print('Error saat lupa kata sandi: $e');
    }
  }
        // Navigator.push(context,MaterialPageRoute(
        //     builder: (context) => const OTPScreen(),
        //   ),
        // );
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
                  'Masukkan email aktif anda!',
                  textAlign: TextAlign.center,
                  style: customText.Poppins_SemiBold(
                    16,
                    Colors.black45,
                    FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 25),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Masukan Email Aktif Anda!',
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
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 60.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your onPressed logic here
                       Navigator.pushReplacement(context,
                                      pageMove.movepage(OTPScreen()));
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
                            'Oke',
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
                const SizedBox(height: 20.0),
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

                      return Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                'belum menerima kode OTP?',
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
                              },
                              child: Text(
                                'Kirim ulang',
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
    );
  }
}
