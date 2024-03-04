import 'package:flutter/material.dart';

class pageMove {
  static PageRouteBuilder movepage(Widget tujuan) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => tujuan,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Start off screen to the right
            end: Offset.zero, // End at the center of the screen
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
