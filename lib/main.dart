<<<<<<< HEAD
import 'package:firebase_core/firebase_core.dart';
import 'package:eduapp/utils/FirebaseServices.dart';
import 'package:eduapp/firebase_options.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/pages/splash_screen.dart';
=======
<<<<<<< HEAD
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/pages/pages_lupakatasandi.dart';
=======
<<<<<<< HEAD
import 'package:eduapp/pages/beranda_pages.dart';
import 'package:eduapp/pages/pages_EdukasiMenu.dart';
import 'package:eduapp/pages/pages_auth.dart';
import 'package:eduapp/pages/pages_authSuccess.dart';
import 'package:eduapp/pages/pages_profil.dart';
import 'package:eduapp/pages/register_screen.dart';
import 'package:eduapp/pages/splash_screen.dart';
import 'package:eduapp/pages/welcome_screen.dart';
import 'package:eduapp/utils/navigationbar.dart';
>>>>>>> c7caaebfb4c79b6385315f79f8eb9ff16ab22b7c
>>>>>>> 0a8dc6eab83380cf8b78d3645725b8f7dda48b14
import 'package:flutter/material.dart';
import 'pages/login_screen.dart';
import 'pages/pages_lupakatasandi.dart';
import 'utils/navigationBar.dart';
=======
import 'package:eduapp/pages/edukasi_psikologi.dart';
import 'package:flutter/material.dart';
import 'pages/login_screen.dart';
>>>>>>> parent of 303f108 (update change content edukasi)

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await FirebaseServices().initNotification();
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