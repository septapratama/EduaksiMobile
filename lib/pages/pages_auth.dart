import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:eduapp/component/custom_pagemove.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Kode OTP'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 75, right: 75),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align content to the start (left)
            children: [
              Text(
                'Kode OTP',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins_SemiBold',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Masukan Kode OTP Anda!',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins_Regular',
                    color: Color.fromARGB(255, 80, 81, 85)),
              ),
              SizedBox(height: 40),
              PinInputTextField(
                pinLength: 4,
                decoration: BoxLooseDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  strokeColorBuilder: PinListenColorBuilder(
                    Color(0xFFCCCCCC), // Default border color
                    Colors.black, // Border color when typing
                  ),
                ),
                autoFocus: true,
                textInputAction: TextInputAction.done,
                onSubmit: (pin) {
                  // You can handle PIN submission here
                  print("OTP submitted: $pin");
                  // Example: Navigate to the next screen after OTP submission
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => NextScreen()),
                  // );
                },
              ),
              // Add space between the OTP input and text button
              SizedBox(height: 35),
              Text(
                'Anda belum menerima kode OTP? ',
                style: TextStyle(fontSize: 16, fontFamily: 'Poppins_Regular'),
              ),
              TextButton(
                onPressed: () {
                  // Handle resend OTP action here
                  print('Resend OTP');
                },
                child: Text(
                  'Kirim ulang',
                  style: TextStyle(
                      fontSize: 14,
                      color: customColor.primaryColors,
                      fontFamily: 'Poppins_SemiBold'),
                ),
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
                    padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 50), // Adjust padding as needed
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
