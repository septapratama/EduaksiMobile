import 'package:eduapp/pages/register_screen.dart';
import 'package:eduapp/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'pages/login_screen.dart';
import 'pages/pages_lupakatasandi.dart';
import 'pages/Home_screen.dart';

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
      home: DashboardScreen(), // Navigate to SplashScreen first
    );
  }
}
