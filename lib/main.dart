import 'package:eduapp/pages/register_screen.dart';
import 'package:eduapp/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'pages/login_screen.dart';
import 'pages/pages_lupakatasandi.dart';

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
      home: RegisterScreen(), // Navigate to SplashScreen first
    );
  }
}
