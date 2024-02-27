import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

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
            const Padding(
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: PageView(
                  controller: _pageController,
                  children: [
                    _buildPage(
                      imagePath: 'assets/images/education_welcome.png',
                      title: 'Selamat Datang',
                      description:
                          'Tempat terbaik untuk mendukung anda sebagai orang tua dalam mendidik dan merawat anak-anak anda.',
                    ),
                    _buildPage(
                      imagePath: 'assets/images/education_welcome.png',
                      title: 'Selamat Datang',
                      description:
                          'Tempat terbaik untuk mendukung anda sebagai orang tua dalam mendidik dan merawat anak-anak anda.',
                    ),
                    _buildPage(
                      imagePath: 'assets/images/education_welcome.png',
                      title: 'Selamat Datang',
                      description:
                          'Tempat terbaik untuk mendukung anda sebagai orang tua dalam mendidik dan merawat anak-anak anda.',
                    ),
                    // Add more pages as needed
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3, // Number of pages in the carousel
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
                      // Add your button onPressed logic here
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Lanjut',
                        style: TextStyle(
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
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 281,
          height: 200,
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
