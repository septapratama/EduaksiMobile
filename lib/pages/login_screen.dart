import 'package:eduapp/controller/controller_register.dart';
import 'package:eduapp/utils/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/component/custom_button.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/component/custom_text.dart';
import 'package:eduapp/pages/pages_lupakatasandi.dart';
import 'package:eduapp/pages/register_screen.dart';
import 'package:eduapp/utils/navigationbar.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

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
                  child: Image.asset(
                    'assets/images/education_login.png',
                    width: 150,
                    height: 150,
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(
                        fontFamily: 'Poppins_SemiBold',
                        color: Color.fromRGBO(30, 84, 135, 1),
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
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
                      style: TextStyle(
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
                      // Add your onPressed logic here
                      Navigator.pushReplacement(context,
                                    pageMove.movepage(BottomNav()));
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
                        // Add your logic for "Masuk dengan Google" here
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
                      
                      return Container(
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
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    pageMove.movepage(RegisterScreen()));
                                // Add logic to navigate to the registration page
                              },
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
