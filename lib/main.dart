import 'package:eduapp/pages/beranda_pages.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:eduapp/pages/pages_auth.dart';
import 'package:eduapp/pages/pages_authSuccess.dart';
import 'package:eduapp/pages/pages_profil.dart';
import 'package:eduapp/pages/register_screen.dart';
import 'package:eduapp/pages/splash_screen.dart';
import 'package:eduapp/pages/welcome_screen.dart';
import 'package:eduapp/utils/navigationbar.dart';
import 'package:flutter/material.dart';
import 'pages/login_screen.dart';
import 'pages/pages_lupakatasandi.dart';
import 'utils/navigationBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eduaksi',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(), // Navigate to SplashScreen first
    );
  }
}
