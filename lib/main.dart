import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/pages/pages_lupakatasandi.dart';
import 'package:flutter/material.dart';

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
      home: LoginScreen(), // Navigate to SplashScreen first
    );
  }
}