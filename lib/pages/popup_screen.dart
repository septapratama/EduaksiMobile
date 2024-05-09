import 'package:eduapp/controller/controller_register.dart';
import 'package:eduapp/pages/login_screen.dart';
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

class PopupScreen extends StatelessWidget {
  final String pesan;
  const PopupScreen({super.key, required this.pesan});
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
                Text(
                  pesan,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins_SemiBold',
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(30, 84, 135, 1),
                    fontSize: 20.0,
                  ),
                ),
                const Text(
                  'Silahkan login kembali',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins_SemiBold',
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(30, 84, 135, 1),
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0), // Adjust horizontal padding as needed
                    child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen())),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}