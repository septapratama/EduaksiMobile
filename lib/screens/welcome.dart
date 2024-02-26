import 'package:education_apps/Layout/Style/styleapp.dart';
import 'package:education_apps/Layout/Widget/ButtonStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color textColor =
        themeData.brightness == Brightness.light ? Colors.black : Colors.white;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Flexible(
                        child: Image.asset(
                          'assets/images/education.png',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Selamat Datang',
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Segoe UI',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'dbfdkbfdhbvkdbfdbfdkbfdhbvkdbfdkbfdhbvkdbfdkbfdhbvkdbfdkbfdhbvkdbfdkbfdhbvkdbfdkbfdhbvkdbfdkbfdhbvkdbfdkbfdhbvkdkbfdhbvkdbfdkbfdhbvkdbfdkbfdhbvkdbfdkbfdhbvkdbfdkbfdhbvkdbfdkbfdhbvkdbfdkbfdhbvk',
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Segoe UI',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.topRight, child: Container()),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: AnimateProgressButton(
                          labelButton: 'Lanjut',
                          labelButtonStyle: StyleApp.largeTextStyle
                              .copyWith(color: textColor),
                          labelProgress: 'Memuat',
                          height: 50,
                          containerColor: Colors.blue.shade800,
                          containerRadius: 10,
                          onTap: () {
                            Future.delayed(Duration(seconds: 2));
                            return false;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
