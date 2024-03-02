import 'package:eduapp/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  final int _totalPages = 3; // Total number of pages

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to the login screen
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginScreen(),
                    transitionsBuilder: (_, animation, __, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(
                              1.0, 0.0), // Start off screen to the right
                          end: Offset.zero, // End at the center of the screen
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 20.0, right: 15.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'Poppins_SemiBold',
                      color: Color.fromRGBO(30, 84, 135, 1),
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return PageView(
                    controller: _pageController,
                    children: [
                      _buildPage(
                        animation:
                            Lottie.asset('assets/images/splahscreen_3.json'),
                        title: 'Selamat Datang',
                        description:
                            'Tempat terbaik untuk mendukung anda sebagai orang tua dalam mendidik dan merawat anak-anak anda.',
                        constraints: constraints,
                      ),
                      _buildPage(
                        animation:
                            Lottie.asset('assets/images/splahscreen_2.json'),
                        title: 'Selamat Datang',
                        description:
                            'Temukan konten yang disesuakan dengan tahapan perkembangan anak anda.',
                        constraints: constraints,
                      ),
                      _buildPage(
                        animation:
                            Lottie.asset('assets/images/splahscreen_1.json'),
                        title: 'Selamat Datang',
                        description:
                            'Dapatkan saran yang relevan sesuai dengan usia dan kebutuhan anak anda.',
                        constraints: constraints,
                      ),
                      // Add more pages as needed
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _totalPages, // Number of pages in the carousel
                (index) => buildDot(index),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _totalPages - 1) {
                        // Navigate to the login screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        _currentPage == _totalPages - 1 ? 'Mulai!' : 'Lanjut',
                        style: const TextStyle(
                          fontFamily: 'Poppins_SemiBold',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildPage({
    required Widget animation, // Change imagePath to animation
    required String title,
    required String description,
    required BoxConstraints constraints,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: constraints.maxHeight * 0.6, // Adjust as per requirement
          child: animation, // Use the 'animation' widget directly
        ),
        const SizedBox(height: 25),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins_Bold',
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(30, 84, 135, 1),
            fontSize: 28.0,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins_SemiBold',
            color: Color.fromRGBO(0, 0, 0, 1),
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
