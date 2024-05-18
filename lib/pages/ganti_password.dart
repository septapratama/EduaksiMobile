import 'package:eduapp/component/custom_alert.dart';
import 'package:eduapp/component/custom_loading.dart';
import 'package:eduapp/controller/controller_register.dart';
import 'package:eduapp/pages/pages_auth.dart';
import 'package:eduapp/pages/popup_screen.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:eduapp/utils/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_button.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/component/custom_text.dart';
import 'package:eduapp/pages/pages_lupakatasandi.dart';
import 'package:eduapp/pages/register_screen.dart';
import 'package:eduapp/utils/navigationbar.dart';
import 'package:provider/provider.dart';

class GaPassScreen extends StatefulWidget {
  final Map<String, dynamic> gaPassData;
  const GaPassScreen({super.key, required this.gaPassData});
  @override
  _GaPassScreenState createState() => _GaPassScreenState();
}

class _GaPassScreenState extends State<GaPassScreen> {
  bool _isPasswordVisible = false;
  bool _isPasswordUlangiVisible = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordUlangiController = TextEditingController();
  final ApiService apiService = ApiService();
  void _gantiPass(BuildContext context) async {
    try {
      String kataSandi = passwordController.text;
      String passUlangi = passwordUlangiController.text;
      if (kataSandi.isEmpty) {
        CostumAlert.show(context, 'Kata sandi baru tidak boleh kosong !', "Gagal kirim ganti kata sandi !", Icons.error, Colors.red);
        return;
      }
      if (passUlangi.isEmpty) {
        CostumAlert.show(context, 'Ulangi Kata sandi tidak boleh kosong', "Gagal kirim ganti kata sandi !", Icons.error, Colors.red);
        return;
      }
      CustomLoading.showLoading(context);
      Map<String, dynamic> response = await apiService.resetPass(widget.gaPassData['email'], widget.gaPassData['otp'], kataSandi, passUlangi);
      CustomLoading.closeLoading(context);
      if (response['status'] == 'success') {
        Navigator.pushReplacement(context, pageMove.movepage(const PopupScreen(pesan: 'Berhasil ganti kata sandi')));
      } else {
        if(response['message'].toString().toLowerCase().contains('expired')){
          CostumAlert.show(context, 'Kode otp kadaluarsa', "Gagal kirim ganti kata sandi !", Icons.error, Colors.red);
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(context, pageMove.movepage(OTPScreen(otpData: {'email':widget.gaPassData['email'], 'cond':'password'})));
          });
        }else{
          CostumAlert.show(context, response['message'], "Gagal kirim ganti kata sandi !", Icons.error, Colors.red);
        }
      }
    } catch (e) {
      print('Error saat ganti kata sandi: $e');
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
                  'Ganti Kata ssandi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins_SemiBold',
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(30, 84, 135, 1),
                    fontSize: 20.0,
                  ),
                ),
                // const Text(
                //   'EduAksi Parenting',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontFamily: 'Poppins_SemiBold',
                //     fontWeight: FontWeight.w800,
                //     color: Color.fromRGBO(30, 84, 135, 1),
                //     fontSize: 18.0,
                //   ),
                // ),
                const SizedBox(height: 60.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kata sandi',
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
                        labelText: 'Masukkan kata sandi',
                        labelStyle: const TextStyle(
                            color: Color.fromRGBO(58, 62, 66, 1),
                            fontWeight: FontWeight.w400),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(30, 84, 135, 1),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 21, 76, 206),
                            width: 2.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
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
                      controller: passwordUlangiController,
                      obscureText: !_isPasswordUlangiVisible,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Ulangi kata sandi',
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
                              _isPasswordUlangiVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors
                                  .black, // Adjust the color of the visibility icon
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordUlangiVisible = !_isPasswordUlangiVisible;
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
                const SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0), // Adjust horizontal padding as needed
                  child: ElevatedButton(
                    onPressed: () =>_gantiPass(context),
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
                            'Ganti Kata sandi',
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