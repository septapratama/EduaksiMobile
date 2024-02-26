import 'package:flutter/material.dart';
import 'package:education_apps/screens/welcome.dart'; // Import your welcome screen widget

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the fade-in animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Navigate to the welcome screen after another delay
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(), // Navigate to your welcome screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 84, 135, 1), // Your background color
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1), // Set the duration of the animation
          child: Image.asset(
            'assets/images/education.png',
            width: 315, // Adjust width and height according to your image size
            height: 282,
          ),
        ),
      ),
    );
  }
}
