import 'package:flutter/material.dart';
import 'dart:async';
import 'welcome_screen.dart'; // Import your welcome screen file

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _mainImageOpacity = 0.0;
  double _newImageOpacity = 0.0;
  bool _showNewImage = false;
  bool _blink = true;
  late Timer _mainImageTimer;
  late Timer _newImageTimer;
  Timer? _blinkTimer; // Initialize as nullable Timer

  @override
  void initState() {
    super.initState();

    // Fade in the main image after 1 second
    _mainImageTimer = Timer(const Duration(seconds: 1), () {
      setState(() {
        _mainImageOpacity = 1.0;
      });
    });

    // Show the new image after 3 seconds
    _newImageTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showNewImage = true;
      });
      // Start the fade-in animation for the new image
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _newImageOpacity = 1.0;
          _startBlinking(); // Start blinking effect
        });
      });
    });

    // Navigate to WelcomeScreen after 5 seconds
    // Navigate to WelcomeScreen after 5 seconds with transition effect
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                WelcomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
    );
  }

  // Method to start blinking effect
  void _startBlinking() {
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!mounted) {
        timer.cancel(); // Cancel the timer if the widget is disposed
        return;
      }
      setState(() {
        _blink = !_blink; // Toggle blink state
      });
    });
  }

  @override
  void dispose() {
    // Cancel _blinkTimer if it is not null
    _blinkTimer?.cancel();
    _mainImageTimer.cancel();
    _newImageTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromRGBO(30, 84, 135, 1), // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _mainImageOpacity,
              duration: const Duration(
                  seconds: 2), // Set the duration of the fade-in animation
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0), // Set border radius
                child: Image.asset('assets/images/education_splashscreen.png'),
              ),
            ),
            const SizedBox(height: 250), // Add some space between the images
            if (_showNewImage)
              AnimatedOpacity(
                opacity:
                    _newImageOpacity, // Opacity controlled by the fade-in animation
                duration: const Duration(
                    seconds: 1), // Set the duration of the fade-in animation
                child: AnimatedOpacity(
                  opacity:
                      _blink ? 1.0 : 0.0, // Toggle opacity based on blink state
                  duration:
                      const Duration(milliseconds: 500), // Blinking duration
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10.0), // Set border radius
                        child: Image.asset(
                          'assets/images/logo_eyes.png',
                          width: 40,
                          height: 40,
                        ), // Your new image
                      ),
                      const SizedBox(
                          width: 10), // Add space between image and text
                      const Text(
                        'Developed by: SixEye’s',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
