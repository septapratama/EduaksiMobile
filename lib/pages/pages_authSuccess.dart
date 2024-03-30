import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_pagemove.dart';

class OTPSuccess extends StatelessWidget {
  const OTPSuccess({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Kode OTP'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 75, right: 75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Register Berhasil',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins_SemiBold',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Anda telah berhasil \n mendaftar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins_Regular',
                  color: Color.fromARGB(255, 80, 81, 85),
                ),
              ),
              SizedBox(height: 20), // Add space between text and image
              Image.asset(
                  'assets/images/group.png'), // Add the image below the text
              SizedBox(height: 40), // Add space below the image

              // Remaining widgets
              SizedBox(height: 35),
              Text(
                textAlign: TextAlign.center,
                'Kembali ke Halaman Login untuk Masuk ke Aplikasi',
                style: TextStyle(fontSize: 16, fontFamily: 'Poppins_Regular'),
              ),

              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Add your onPressed logic here
                    Navigator.pushReplacement(
                        context, pageMove.movepage(LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Oke',
                    style: TextStyle(
                      fontFamily: 'Poppins_SemiBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
