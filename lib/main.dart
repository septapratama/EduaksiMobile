import 'package:flutter/material.dart';
import 'package:education_apps/screens/splashscreen.dart'; // Import your splash screen widget
import 'package:education_apps/screens/welcome.dart'; // Import your splash screen widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduAksi',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: SplashScreenWrapper(),
      debugShowCheckedModeBanner: false, // Display SplashScreenWrapper initially
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  @override
  _SplashScreenWrapperState createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay to display splash screen
    Future.delayed(Duration(seconds: 2), () {
      // After the delay, navigate to the main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(), // Navigate to your main screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(); // Return your splash screen widget
  }
}
