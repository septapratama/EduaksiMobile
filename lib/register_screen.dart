import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama',
                      style: TextStyle(
                        fontFamily: 'Poppins_SemiBold',
                        color: Color.fromRGBO(30, 84, 135, 1),
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(
                              30, 84, 135, 1), // Default text color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(30, 84, 135,
                                1), // Border color for the enabled state
                            width: 2.0, // Border width for the enabled state
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 21, 76,
                                206), // Border color for the focused state
                            width: 2.0, // Border width for the focused state
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black, // Text color for the input text
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No Telepon',
                      style: TextStyle(
                        fontFamily: 'Poppins_SemiBold',
                        color: Color.fromRGBO(30, 84, 135, 1),
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'No Telepon',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(
                              30, 84, 135, 1), // Default text color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(30, 84, 135,
                                1), // Border color for the enabled state
                            width: 2.0, // Border width for the enabled state
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 21, 76,
                                206), // Border color for the focused state
                            width: 2.0, // Border width for the focused state
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black, // Text color for the input text
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Masukkan Kata Sandi',
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
                        labelText: 'Masukkan Kata Sandi',
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(
                              30, 84, 135, 1), // Default text color
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(30, 84, 135,
                                1), // Border color for the enabled state
                            width: 2.0, // Border width for the enabled state
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 21, 76,
                                206), // Border color for the focused state
                            width: 2.0, // Border width for the focused state
                          ),
                        ),
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
                        color: Colors.black, // Text color for the input text
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
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Ulangi Kata Sandi',
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(
                              30, 84, 135, 1), // Default text color
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(30, 84, 135,
                                1), // Border color for the enabled state
                            width: 2.0, // Border width for the enabled state
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 21, 76,
                                206), // Border color for the focused state
                            width: 2.0, // Border width for the focused state
                          ),
                        ),
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
                        color: Colors.black, // Text color for the input text
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0), // Adjust horizontal padding as needed
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your onPressed logic here
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
                                'Apakah anda sudah memiliki akun?',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins_SemiBold',
                                  color: Color.fromRGBO(0, 0, 0, 0.445),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Add logic to navigate to the registration page
                              },
                              child: Text(
                                'Masuk',
                                style: TextStyle(
                                  fontSize:
                                      fontSize, // Use the fontSize variable here
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins_SemiBold',
                                  color: Color.fromRGBO(30, 84, 135, 1),
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
